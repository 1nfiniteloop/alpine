FROM alpine:3.8

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    bash \
    patch \
    patchutils \
    s6

ADD rootfs /

ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["/bin/bash -l"]

