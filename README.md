# liferaynetes

## TODO
 - elasticsearfch osrgi envistä?
    tai tälleen:    -Djgroups.tcp.address=${own_address} \
 - psql ncatin sijaan (t: masa)
 - curlaa kerran localhostia niin näkyy logista koska päällä

KOMMENTIT:
  - https://stackoverflow.com/questions/35917945/tomcat-how-to-persist-a-session-immediately-to-disk-using-persistentmanager
  - KONFFIS: https://tomcat.apache.org/tomcat-9.0-doc/config/manager.html

 - jotain oikesti hyvää: https://tomcat.apache.org/tomcat-9.0-doc/cluster-howto.html

  - https://community.liferay.com/forums/-/message_boards/message/13147457
- https://www.xtivia.com/liferay-session-replication-tomcat/

----> https://www.lodatoluciano.com/en/blog/liferay-high-availability

############################################
https://community.liferay.com/forums/-/message_boards/message/4746849
I'm not sure if this is related to your issue, but Liferay does automatically invalidates the current session when a user logs into the portal. Take a look at the property session.enable.phishing.protection for more info.
##########################################

## clustering:
 - https://www.lodatoluciano.com/en/blog/liferay-high-availability
 - https://community.liferay.com/forums/-/message_boards/message/13147457



login: test@liferay.com/test

java -XX:+PrintFlagsFinal -version | grep -Ei "maxheapsize|maxram"

PGPASSWORD=asdf89asdj8fsjad89fjs89dafj98sadf89fadsj89afsd psql -h exoliferay-de-cluster.cluster-cbhent2th1nq.eu-central-1.rds.amazonaws.com -U exoliferay_de
psql

- https://issues.liferay.com/browse/LPS-89569

## NOTES
- PDF processing creates another java process
- fonts for CAPTCHA
  https://github.com/docker-library/openjdk/blob/master/11/jdk/oracle/Dockerfile#L8
  --> libfreetype6 ubuntu package provides libfreetype.so.6
  https://bugs.launchpad.net/ubuntu/+source/openjdk-lts/+bug/1780151
  --> then next error is missing libfontconfig1 that is provided by libfontconfig1

- https://docs.liferay.com/ce/portal/7.1-latest/propertiesdoc/portal.properties.html
- https://github.com/liferay/liferay-portal/blob/master/portal-impl/src/portal.properties

- https://skaffold.dev/docs/references/yaml/


## TODO
 - logs in /app/logs
 - https property
      web.server.protocol=https
 - catalina.out and apache log
 - elastic 6.5
  - automatic backup from ingress

 - /app/osgi
  - state, work, temp
