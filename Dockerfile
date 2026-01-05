ARG BASE_IMAGE=debian:13.2-slim@sha256:4bcb9db66237237d03b55b969271728dd3d955eaaa254b9db8a3db94550b1885
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2026-01-05

LABEL Name="senzing/base-image-debian" \
      Maintainer="support@senzing.com" \
      Version="1.0.24"

# Install packages via apt-get.

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      apt-transport-https \
      git \
      gnupg2 \
      gpg \
      jq \
      make \
      wget \
 && apt-get install -y --reinstall ca-certificates \
 && update-ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Install Java-17.

RUN wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null \
 && echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list

RUN apt-get update \
 && apt-get install -y --no-install-recommends temurin-17-jdk \
 && rm -rf /var/lib/apt/lists/*

# Tricky code: Since maven tries to install its own Java,
# maven needs to be installed after the required Java is installed.
# Note: apt install does not download maven 3.9.6.
# A more "manual" method is needed.
# See https://linuxize.com/post/how-to-install-apache-maven-on-debian-10/

RUN wget https://downloads.apache.org/maven/maven-3/3.9.12/binaries/apache-maven-3.9.12-bin.tar.gz -P /opt \
 && tar xf /opt/apache-maven-*.tar.gz -C /opt \
 && ln -s /opt/apache-maven-3.9.12 /opt/maven

# check for java 17

HEALTHCHECK CMD java --version | grep -E "17\.[0-9]+\.[0-9]+"

# Make non-root container.

USER 1001

# Set environment variables for USER 1001.

ENV M2_HOME=/opt/maven
ENV MAVEN_HOME=/opt/maven
ENV PATH=${PATH}:${M2_HOME}/bin
