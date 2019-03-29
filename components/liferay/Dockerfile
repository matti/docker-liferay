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

RUN useradd -ms /bin/bash lportal

WORKDIR /app

COPY --chown=lportal:lportal --from=builder /liferay /app
COPY --from=builder /openjdk /opt/openjdk/

COPY layers/app /app

ENV JAVA_HOME=/opt/openjdk
ENV PATH=/opt/openjdk/bin:$PATH

ENTRYPOINT [ "/app/entrypoint.sh" ]
