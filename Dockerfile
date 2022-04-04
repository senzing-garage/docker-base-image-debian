ARG BASE_IMAGE=debian:11.3-slim@sha256:78fd65998de7a59a001d792fe2d3a6d2ea25b6f3f068e5c84881250373577414
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2022-04-01

LABEL Name="senzing/base-image-debian" \
      Maintainer="support@senzing.com" \
      Version="1.0.7"

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

RUN wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - \
 && add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ \
 && apt update \
 && apt install -y adoptopenjdk-11-hotspot \
 && rm -rf /var/lib/apt/lists/*

# Tricky code: Since maven tries to install its own Java,
# maven needs to be installed after the required Java is installed.
# Note: apt install does not download maven 3.6.3.
# A more "manual" method is needed.
# See https://linuxize.com/post/how-to-install-apache-maven-on-debian-10/

RUN wget https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /opt \
 && tar xf /opt/apache-maven-*.tar.gz -C /opt \
 && ln -s /opt/apache-maven-3.6.3 /opt/maven

ENV M2_HOME /opt/maven
ENV MAVEN_HOME /opt/maven
ENV PATH ${PATH}:${M2_HOME}/bin
