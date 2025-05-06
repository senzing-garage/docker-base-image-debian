# Docker Base Image Debian

If you are beginning your journey with [Senzing],
please start with [Senzing Quick Start guides].

You are in the [Senzing Garage] where projects are "tinkered" on.
Although this GitHub repository may help you understand an approach to using Senzing,
it's not considered to be "production ready" and is not considered to be part of the Senzing product.
Heck, it may not even be appropriate for your application of Senzing!

## Overview

This repository shows best practices for creating a Debian-based
docker image upon which to deploy Senzing.

### Related artifacts

1. [DockerHub]

### Contents

1. [Expectations]
   1. [Space]
   1. [Time]
   1. [Background knowledge]
1. [Develop]
   1. [Prerequisite software]
   1. [Clone repository]
   1. [Build docker image for development]
1. [References]

### Legend

1. :thinking: - A "thinker" icon means that a little extra thinking may be required.
   Perhaps you'll need to make some choices.
   Perhaps it's an optional step.
1. :pencil2: - A "pencil" icon means that the instructions may need modification before performing.
1. :warning: - A "warning" icon means that something tricky is happening, so pay attention.

## Expectations

### Space

This repository and demonstration require 6 GB free disk space.

### Time

Budget 40 minutes to get the demonstration up-and-running, depending on CPU and network speeds.

### Background knowledge

This repository assumes a working knowledge of:

1. [Docker]

## Develop

### Prerequisite software

The following software programs need to be installed:

1. [git]
1. [make]
1. [Docker]

### Clone repository

For more information on environment variables,
see [Environment Variables].

1. Set these environment variable values:

   ```console
   export GIT_ACCOUNT=senzing
   export GIT_REPOSITORY=docker-base-image-debian
   export GIT_ACCOUNT_DIR=~/${GIT_ACCOUNT}.git
   export GIT_REPOSITORY_DIR="${GIT_ACCOUNT_DIR}/${GIT_REPOSITORY}"
   ```

1. Follow steps in [clone-repository] to install the Git repository.

### Build docker image for development

1. **Option #1:** Using `docker` command and GitHub.

   ```console
   sudo docker build \
     --tag senzing/base-image-debian \
     https://github.com/senzing-garage/docker-base-image-debian.git#main
   ```

1. **Option #2:** Using `docker` command and local repository.

   ```console
   cd ${GIT_REPOSITORY_DIR}
   sudo docker build --tag senzing/base-image-debian .
   ```

1. **Option #3:** Using `make` command.

   ```console
   cd ${GIT_REPOSITORY_DIR}
   sudo make docker-build
   ```

   Note: `sudo make docker-build-development-cache` can be used to create cached docker layers.

## References

[Senzing]: https://senzing.com/
[Senzing Quick Start guides]: https://docs.senzing.com/quickstart/
[Senzing Garage]: https://github.com/senzing-garage
[DockerHub]: https://hub.docker.com/r/senzing/base-image-debian
[Expectations]: #expectations
[Space]: #space
[Time]: #time
[Background knowledge]: #background-knowledge
[Develop]: #develop
[Prerequisite software]: #prerequisite-software
[Clone repository]: #clone-repository
[Build docker image for development]: #build-docker-image-for-development
[References]: #references
[Docker]: https://github.com/senzing-garage/knowledge-base/blob/main/WHATIS/docker.md
[git]: https://github.com/senzing-garage/knowledge-base/blob/main/WHATIS/git.md
[make]: https://github.com/senzing-garage/knowledge-base/blob/main/WHATIS/make.md
[Environment Variables]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md
[clone-repository]: https://github.com/senzing-garage/knowledge-base/blob/main/HOWTO/clone-repository.md
