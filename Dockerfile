FROM debian:10.2

LABEL Name="senzing-docker-base-image-debian" \
      Maintainer="support@senzing.com" \
      Version="1.0.1"

# Install packages via apt

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

# Install Java-8 - To be removed after Senzing API server supports Java 11
# Once fixed, add "default-jdk" to "apt install ..."

RUN wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - \
 && add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ \
 && apt update \
 && apt install -y adoptopenjdk-11-hotspot \
 && rm -rf /var/lib/apt/lists/*

# Tricky code: Since maven tries to install its own Java,
# maven needs to be installed after the required Java is installed.

RUN apt update \
 && apt install -y --no-install-recommends \
      maven \
 && rm -rf /var/lib/apt/lists/*
