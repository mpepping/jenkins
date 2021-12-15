# Jenkins LTS

[![Docker Image CI](https://github.com/mpepping/jenkins/actions/workflows/dockerimage.yml/badge.svg)](https://github.com/mpepping/jenkins/actions/workflows/dockerimage.yml)

Jenkins LTS with some additions. See <https://github.com/mpepping/jenkins/> for details.

Added packages are: 

* ca-certificates (debian package)
* docker-ce client
* jq

The use case for this container is to run Jenkins and use the docker engine on the host to run jobs. Using the docker socket on the host.

To run via docker cli:

```lang=bash
docker run -d -p 8080:8080 \
  -v $PWD/jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  ghcr.io/mpepping/jenkins:latest
```

Via docker-compose:

```lang=yaml
version: '3'
services:
  ci:
    container_name: jenkins
    image: ghcr.io/mpepping/jenkins:latest
    volumes:
    - jenksins_home:/var/jenkins_home
    - /var/run/docker.sock:/var/run/docker.sock
    ports:
    - "8080:8080"
    - "50000:50000"
    restart: unless-stopped

volumes:
  jenkins_home:
    driver: local
```

## Version

2.319.1-lts-jdk11

