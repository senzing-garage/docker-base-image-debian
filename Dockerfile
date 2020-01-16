FROM debian:buster

LABEL Name="senzing-docker-base-image-debian" \
      Maintainer="support@senzing.com" \
      Version="1.0.0"

# Install packages via apt
RUN echo "deb http://ftp.us.debian.org/debian sid main" >> /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
     apt-transport-https \
     git \
     gnupg2 \
     jq \
     make \
     openjdk-8-jdk \
     sudo \
     wget

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
     maven \
 && rm -rf /var/lib/apt/lists/*
