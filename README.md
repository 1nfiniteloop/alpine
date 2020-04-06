# Alpine

This Alpine Docker-image serves as a base for other containers.

## Versions

* `1nfiniteloop/alpine:latest` from
   [here](https://github.com/1nfiniteloop/alpine).

## Volumes

* /etc/patch.d *Optionally, used during development*

## Ports

*None*

## Environment variables

*None*

## Author

[Lars Gunnarsson](https://github.com/1nfiniteloop)

## License

MIT

## Usage

### Run

Start container with
`docker run --rm -it --name alpine 1nfiniteloop/alpine:latest /bin/bash -l`.

### Customize

Path `/etc/entrypoint.d` contains scripts which runs before the s6-service
supervisor starts. They are intended to handle all necessary initial
configurations based on environment variables provided from docker cmdline. Note
that scripts will run on *each* startup, i.e. not only once.

Path `/etc/patch.d` contains patches applied on startup. They are intended to
customize configuration-files. I believe applying patches makes changes more
visible, compared to just having an overlay file copied into the container.

#### Create configuration patches

1. Start container with a bind-mount:
```bash
docker run \
  --rm \
  -it \
  --name alpine \
  --user $(id -u):$(id -g) \
  --volume $(pwd)/overlay/etc/patch.d:/etc/patch.d \
  1nfiniteloop/alpine:latest /bin/bash -l
```
2. Create a original copy of the file to be changed, example:
   `cp /etc/inputrc /etc/inputrc~`.
3. Create the patch with `make-patch /etc/inputrc`.
