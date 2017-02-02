FROM jenkins:latest

# This is the same ARG from jenkins:latest. We don't want to modify it.
# However, we need to switch the user back to root for additional installation.
ARG user=jenkins
USER root

# Install prerequisites for docker, and other tools.
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    build-essential \
    zip \
    && rm -rf /var/lib/apt/lists/*

# Get the apt key.
RUN curl -fsSL https://yum.dockerproject.org/gpg | apt-key add -

# Verify the fingerprint matches the key.
RUN /bin/bash -c "ID_TO_MATCH=58118E89F3A912897C070ADBF76221572C52609D; \
    grep \$ID_TO_MATCH <(apt-key fingerprint \$ID_TO_MATCH | sed 's/ //g')"

# Add the docker-engine repository.
RUN add-apt-repository \
    "deb https://apt.dockerproject.org/repo/ \
    debian-$(lsb_release -cs) \
    main"

# Install docker.
RUN apt-get update && apt-get install -y \
    docker-engine \
    && rm -rf /var/lib/apt/lists/*

# Set the default variable for the tcp connection to docker so that
# this can be overridden. This IP should work in many cases.
ENV DOCKER_HOST tcp://172.17.42.1:2375

# Finally, switch the user back.
USER ${user}
