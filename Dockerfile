ARG BASE_IMAGE=debian:11.9-slim@sha256:0e75382930ceb533e2f438071307708e79dc86d9b8e433cc6dd1a96872f2651d
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2024-05-21

LABEL Name="senzing/base-image-debian" \
  Maintainer="support@senzing.com" \
  Version="1.0.23"

# Install packages via apt-get.

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  apt-transport-https \
  git \
  gnupg2 \
  jq \
  make \
  software-properties-common \
  wget \
  && rm -rf /var/lib/apt/lists/*

# Install Java-11.

RUN mkdir -p /etc/apt/keyrings \
  && wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public > /etc/apt/keyrings/adoptium.asc

RUN echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" >> /etc/apt/sources.list

RUN apt-get update \
  && apt-get install -y temurin-11-jdk \
  && rm -rf /var/lib/apt/lists/*

# Tricky code: Since maven tries to install its own Java,
# maven needs to be installed after the required Java is installed.
# Note: apt install does not download maven 3.9.6.
# A more "manual" method is needed.
# See https://linuxize.com/post/how-to-install-apache-maven-on-debian-10/

RUN wget https://downloads.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz -P /opt \
  && tar xf /opt/apache-maven-*.tar.gz -C /opt \
  && ln -s /opt/apache-maven-3.9.6 /opt/maven

# check for java 11

HEALTHCHECK CMD java --version | grep -E "11\.[0-9]+\.[0-9]+"

# Make non-root container.

USER 1001

# Set environment variables for USER 1001.

ENV M2_HOME /opt/maven
ENV MAVEN_HOME /opt/maven
ENV PATH ${PATH}:${M2_HOME}/bin
