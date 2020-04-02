FROM alpine:3.11

RUN apk update \
    && apk upgrade \
    && apk add --no-cache \
        bash \
        patch \
        patchutils \
        s6 \
    && rm -r /var/cache/apk/*

ADD rootfs /

ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["/bin/s6-svscan", "/etc/s6"]
