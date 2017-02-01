FROM jenkins:latest

ARG user=jenkins
USER root
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL https://yum.dockerproject.org/gpg | apt-key add -
# verify the fingerprint matches the key
RUN /bin/bash -c "ID_TO_MATCH=58118E89F3A912897C070ADBF76221572C52609D; \
    grep \$ID_TO_MATCH <(apt-key fingerprint \$ID_TO_MATCH | sed 's/ //g')"
RUN add-apt-repository \
    "deb https://apt.dockerproject.org/repo/ \
    debian-$(lsb_release -cs) \
    main"
RUN apt-get update && apt-get install -y \
    docker-engine \
    && rm -rf /var/lib/apt/lists/*
# Set the default variable for the tcp connection to docker so that
# this can be overridden. This IP should work in many cases.
ENV DOCKER_HOST tcp://172.17.42.1:2375

USER ${user}
