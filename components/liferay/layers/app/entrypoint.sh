#!/usr/bin/env bash
set -e

_term() {
  echo "sleeping 1s before shutdown"
  sleep 1
}

trap _term SIGTERM

echo "Liferaynetes starting"

set +x
  cat /app/osgi/configs/com.liferay.portal.search.elasticsearch6.configuration.ElasticsearchConfiguration.config
set -x

own_address=$(awk 'END{print $1}' /etc/hosts)
echo "my address: ${own_address}"

export JAVA_OPTS="-Djgroups.tcp.address=${own_address}"
tomcat-9.0.10/bin/startup.sh

sleep 3

set +x
  tail -f tomcat-9.0.10/logs/catalina.out &
set -x

tail -f /dev/null &
wait $!
