Jenkins with Docker
===================

This is an extended Jenkins CI docker container build definition that is intended to have an installation of Docker baked into the container. The purpose is not building inside the container but using Docker to call `docker` via `docker --host` to build outside of the container.

I will be including the DOCKER_HOST environment to your to pass in, that will consequently be used by default on default calls to `docker` from within the container.

This is a work in progress.
