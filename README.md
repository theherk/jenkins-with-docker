Jenkins with Docker
===================

This is an extended Jenkins CI docker container build definition that is intended to have an installation of Docker baked into the container. The purpose is not building inside the container but using Docker to call `docker` via `docker --host` to build outside of the container.

The same could be accomplished by sharing the socket into the container. The end result is the same. Once you crash into the container, you can just run docker ps and see yourself running outside the container. It's an out-of-container experience.

I have included the DOCKER_HOST environment to your to pass in, that will consequently be used by default on default calls to `docker` from within the container. Of course, since by default the docker host is often 172.17.42.1 you may not have to touch this at all.
