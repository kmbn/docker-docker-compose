[![pipeline status](https://gitlab.com/kmbn/docker-docker-compose/badges/master/pipeline.svg)](https://gitlab.com/kmbn/docker-docker-compose/commits/master)

# Docker Image with Docker and Docker-Compose
This image contains `Docker`, `docker-compose`, and `Python 3`. It is based on `docker:stable`, the official image for Docker.

## Why would I use this?
Use this image if you need run tasks with docker-compose. For instance, if you use GitLab CI/CD and you need to build and test a project that relies on docker-compose, you can create a GitLab Runner based on this image, which will allow you to use docker-compose to for your tests. You can also then use Docker itself to push a successfully built and tested image to a container registry.

## Using with GitLab CI/CD Pipelines and GitLab Runner

To use Docker and docker-compose in a GitLab CI/CD pipeline you will need to set up a private GitLab Runner.

There are two conditions for using Docker/docker-compose in a runner:
1. The runner's image will need to include Docker and docker-compose
2. The runner will need to have access to the Docker socket of the host.

Below is an example of a `config.toml` file for such a GitLab runner.

The settings that make it all work: `exectutor = docker`, `image = kmbn/docker-compose` (so that Docker and docker-compose are included in the image), and `volumes = ["/var/run/docker.sock:/var/run/docker.sock", "/cache"]` (so that the runner has access to the host's Docker socket).

You can copy/paste this into your `config.toml` file. (Note: you'll have to change `url` and `token` based on your project's settings.)

```
concurrent = 1
check_interval = 0

[session_server]
  session_timeout = 1800

[[runners]]
  name = "planet"
  url = "url for your GitLab instance (https://gitlab.com/ if you use gitlab.com"
  token = "your project's token"
  executor = "docker"
  [runners.custom_build_dir]
  [runners.docker]
    tls_verify = false
    image = "kmbn/docker-compose"
    privileged = false
    disable_entrypoint_overwrite = false
    oom_kill_disable = false
    disable_cache = false
    volumes = ["/var/run/docker.sock:/var/run/docker.sock", "/cache"]
    shm_size = 0
  [runners.cache]
    [runners.cache.s3]
    [runners.cache.gcs]
```
