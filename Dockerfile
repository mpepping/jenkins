FROM jenkins/jenkins:lts

LABEL maintainer "Martijn Pepping <martijn.pepping@automiq.nl>"

# Switch to root for the build context
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

# Switch to the runtime user
USER jenkins

# Set correct timezone
ENV TZ Europe/Amsterdam