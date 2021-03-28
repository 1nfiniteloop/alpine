# Alpine

This Alpine Docker-image serves as a base for other containers.

## Versions

* `1nfiniteloop/alpine:latest` from
   [here](https://github.com/1nfiniteloop/alpine).

## Volumes

* `/etc/patch.d` - _Optionally, used during development_

## Ports

_None_

## Environment variables

_None_

## Usage

### Run

Start container with:

    docker run \
      --rm \
      -it \
      --name alpine \
      1nfiniteloop/alpine:latest \
      /bin/bash -l

### Customize

`/etc/entrypoint.d` contain scripts to run before the s6-service supervisor
starts. Example to make configurations based on environment variables provided
from docker run cmdline. Note that scripts will run on _each_ startup,
not only once.

`/etc/patch.d` contain patches to be applied on startup. I believe applying
patches to configuration files become more transparent, compared to just copy
an overlay file into the container.

### Create patches

1. Start container with a bind-mount:

      docker run \
        --rm \
        -it \
        --name alpine \
        --user $(id -u):$(id -g) \
        --volume $(pwd)/overlay/etc/patch.d:/etc/patch.d \
        1nfiniteloop/alpine:latest /bin/bash -l

2. Create a copy of the original configuration file, to diff against. Example:
   `cp /etc/inputrc /etc/inputrc~`.

3. Make changes and create the patch with `make-patch /etc/inputrc`.
