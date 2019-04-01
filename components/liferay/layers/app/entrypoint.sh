#!/usr/bin/env bash
set -eo pipefail
set +x

_term() {
  echo "killing tomcat with -15"
  kill -TERM "$tomcat_pid"
  while true; do
    set +e
      kill -0 "$tomcat_pid" || break
    set -e
    
    echo "tomcat still alive"
    sleep 1
  done
  echo "tomcat exited"
  exit 0
}

trap _term SIGTERM

echo "Liferaynetes starting"

while true; do
  echo "waiting for postgres:5432"
  nc -w 1 -z postgres 5432 && break
  sleep 1
done

while true; do
  echo "waiting for elasticsearch:9300"
  nc -w 1 -z elasticsearch 9300 && break
  sleep 1
done

set +x
  cat /app/osgi/configs/com.liferay.portal.search.elasticsearch6.configuration.ElasticsearchConfiguration.config
set -x

own_address=$(awk 'END{print $1}' /etc/hosts)
echo "my address: ${own_address}"

if [ "${MEMORY_LIMIT_BYTES}" = "" ]; then
  export MEMORY_LIMIT_BYTES=137438953472
fi

max_ram_bytes=$(expr ${MEMORY_LIMIT_BYTES} - ${MEMORY_LIMIT_BYTES} / 10)

# Dorg.apache.catalina.loader.WebappClassLoader.ENABLE_CLEAR_REFERENCES=false
# "If true, Tomcat attempts to null out any static or final fields from loaded...around for apparent garbage collection bugs and application coding errors. There have been some issues reported with log4j when this option is true."

# CATALINA_OPTS and JAVA_OPTS are not forwarded for "java"
# MaxRAM might not matter, XmX higher than MaxRAM/3 seems to OOMKill
export _JAVA_OPTIONS="\
-XX:MaxRAM=${max_ram_bytes} \
-XX:MaxRAMPercentage=${MAX_RAM_PERCENTAGE:-25} \
-Dorg.apache.catalina.loader.WebappClassLoader.ENABLE_CLEAR_REFERENCES=false \
-Dfile.encoding=UTF8 \
-Djgroups.tcp.address=${own_address} \
"

java -XX:+PrintFlagsFinal -version | grep -Ei "maxheapsize|maxram"

set +x
  if [[ "${HOSTNAME}" =~ ^web-. ]]; then
    ordinal="${HOSTNAME##*-}"
    leader_to_wait_for="web-0"
  else
    # docker-compose hostnames are asdfasdffs
    ordinal=0
    leader_to_wait_for=$(hostname)
  fi

  echo "HOSTNAME: $HOSTNAME"
  echo "leader: $leader_to_wait_for"
  echo "ordinal: $ordinal"

  if [ "${HOSTNAME}" = "${leader_to_wait_for}" ]; then
    echo "I'm ${leader_to_wait_for}, so I start immediately."  
  else
    startup_delay_multiplier=${STARTUP_DELAY_MULTIPLIER:-120}
    startup_delay=$(expr ${ordinal} \* ${startup_delay_multiplier})
    echo "sleeping ${ordinal} * 60 = ${startup_delay} to mitigate https://issues.liferay.com/browse/LPS-89569"
    sleep $startup_delay

    while true; do
      curl --head --max-time 1 --silent "${leader_to_wait_for}":8080 && break
      sleep 1
      echo "waiting for ${leader_to_wait_for}:8080"
    done
  fi
set -x

tomcat-9.0.10/bin/catalina.sh run &
tomcat_pid="$!"

set +x
while true; do
  set +e
    stats=$(ps -eo pcpu,pmem,comm,pid,maj_flt,min_flt,rss,vsz | numfmt --header --to=iec --field 4-5 | numfmt --header --from-unit=1024 --to=iec --field 6-7 | grep java)
    echo "STATS: ${stats}"
  set -e

  kill -0 "$tomcat_pid" || break
  sleep 2
done

echo "tomcat exited!"
