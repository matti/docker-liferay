# liferaynetes


    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/mandatory.yaml
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/cloud-generic.yaml


login: test@liferay.com/test

java -XX:+PrintFlagsFinal -version | grep -Ei "maxheapsize|maxram"


- https://issues.liferay.com/browse/LPS-89569

## NOTES
- PDF processing creates another java process
- fonts for CAPTCHA
  https://github.com/docker-library/openjdk/blob/master/11/jdk/oracle/Dockerfile#L8
  --> libfreetype6 ubuntu package provides libfreetype.so.6
  https://bugs.launchpad.net/ubuntu/+source/openjdk-lts/+bug/1780151
  --> then next error is missing libfontconfig1 that is provided by libfontconfig1

## TODO

 - https property
      web.server.protocol=https
 - catalina.out and apache log
 - elastic 6.5
  - automatic backup from ingress

 - /app/osgi
  - state, work, temp
