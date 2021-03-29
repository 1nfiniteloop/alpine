FROM alpine:3.11

RUN apk update \
    && apk upgrade \
    && apk add --no-cache \
        bash \
        patch \
        patchutils \
        s6 \
    && rm -r /var/cache/apk/*

ADD overlay /

ENTRYPOINT ["/usr/local/bin/entrypoint"]
CMD ["/bin/s6-svscan", "/etc/services.d"]
