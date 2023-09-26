ARG BASE_IMAGE=debian:11.7-slim@sha256:3bc5e94a0e8329c102203c3f5f26fd67835f0c81633dd6949de0557867a87fac
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2023-09-11

LABEL Name="senzing/base-image-debian" \
      Maintainer="support@senzing.com" \
      Version="1.0.19"

# Install packages via apt.

RUN apt update \
 && apt install -y --no-install-recommends \
      apt-transport-https \
      git \
      gnupg2 \
      jq \
      make \
      software-properties-common \
      sudo \
      wget \
 && rm -rf /var/lib/apt/lists/*

# Install Java-11.

RUN mkdir -p /etc/apt/keyrings \
 && wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public > /etc/apt/keyrings/adoptium.asc

RUN echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" >> /etc/apt/sources.list

RUN apt update \
 && apt install -y temurin-11-jdk \
 && rm -rf /var/lib/apt/lists/*

# Tricky code: Since maven tries to install its own Java,
# maven needs to be installed after the required Java is installed.
# Note: apt install does not download maven 3.6.3.
# A more "manual" method is needed.
# See https://linuxize.com/post/how-to-install-apache-maven-on-debian-10/

RUN wget https://downloads.apache.org/maven/maven-3/3.9.2/binaries/apache-maven-3.9.2-bin.tar.gz -P /opt \
 && tar xf /opt/apache-maven-*.tar.gz -C /opt \
 && ln -s /opt/apache-maven-3.9.2 /opt/maven

ENV M2_HOME /opt/maven
ENV MAVEN_HOME /opt/maven
ENV PATH ${PATH}:${M2_HOME}/bin
