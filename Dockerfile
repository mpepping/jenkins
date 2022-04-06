FROM jenkins/jenkins:lts

LABEL maintainer "Martijn Pepping <martijn.pepping@automiq.nl>"
LABEL org.opencontainers.image.source https://github.com/mpepping/jenkins
LABEL org.opencontainers.image.url https://github.com/mpepping/jenkins

USER root

# Install pre-reqs
RUN apt-get update && \
    apt-get install -y sudo apt-transport-https ca-certificates curl jq software-properties-common && \
    /bin/bash -c 'curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -' && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

# Install docker-ce and add the `jenkins` user to the users,docker system groups
RUN apt-get update && \
    apt-get install -y docker-ce && \
    rm -rf /var/lib/apt/lists/* && \
    usermod -aG docker,users jenkins

USER jenkins

# Set correct timezone
ENV TZ Europe/Amsterdam
