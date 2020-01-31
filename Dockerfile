FROM debian:10.2

LABEL Name="senzing-docker-base-image-debian" \
      Maintainer="support@senzing.com" \
      Version="1.0.1"

# Install packages via apt

RUN echo "deb http://ftp.us.debian.org/debian sid main" >> /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
     apt-transport-https \
     git \
     gnupg2 \
     jq \
     make \
     maven \
     openjdk-8-jdk \
     sudo \
     wget \
 && rm -rf /var/lib/apt/lists/*

# Install Java-8 - To be removed after Senzing API server supports Java 11
# Once fixed, add "default-jdk" to "apt install ..."

# RUN wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add -
# RUN add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
# RUN apt update
# RUN apt install adoptopenjdk-8-hotspot
