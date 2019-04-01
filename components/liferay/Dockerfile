FROM ubuntu:18.04 as builder

RUN apt-get update && apt-get upgrade -y
RUN apt-get update && apt-get install -y \
  p7zip-full

WORKDIR /
COPY liferay-ce-portal-tomcat-7.1.2-ga3-20190107144105508.7z .
RUN 7z x liferay-ce-portal-tomcat-7.1.2-ga3-20190107144105508.7z
RUN mv liferay-ce-portal-7.1.2-ga3 /liferay

COPY openjdk-11.0.2_linux-x64_bin.tar.gz /openjdk.tgz
WORKDIR /openjdk
RUN tar --extract --file /openjdk.tgz --directory "/openjdk" --strip-components 1

FROM ubuntu:18.04
RUN apt-get update && apt-get upgrade -y

# https://github.com/docker-library/openjdk/blob/master/11/jdk/oracle/Dockerfile#L8
# https://bugs.launchpad.net/ubuntu/+source/openjdk-lts/+bug/1780151
RUN apt-get update && apt-get install -y \
  netcat-openbsd curl wget nano htop iputils-ping \
  fontconfig libfontconfig1 libfreetype6

RUN useradd -ms /bin/bash liferay

WORKDIR /app

COPY --from=builder /openjdk /opt/openjdk/
ENV JAVA_HOME=/opt/openjdk
ENV PATH=/opt/openjdk/bin:$PATH

# https://github.com/docker-library/openjdk/blob/master/11/jdk/oracle/Dockerfile#L45
# "you may want to use class data sharing archive in the OpenJDK image, to improve startup time and memory sharing. While there is a JEP to make CDS part of the default build at http://openjdk.java.net/jeps/341 at some point in the future, -Xshare:dump still needs to be run on install in current releases.""

RUN java -Xshare:dump

COPY --chown=liferay:liferay --from=builder /liferay /app
COPY --chown=liferay:liferay layers/app .

USER liferay

ENTRYPOINT [ "/app/entrypoint.sh" ]
