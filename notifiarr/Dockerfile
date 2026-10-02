ARG BUILD_FROM=ghcr.io/notifiarr/notifiarr:latest
FROM $BUILD_FROM

ARG BUILD_ARCH

ENV TZ=UTC
ENV PATH=/bin:/usr/bin:/sbin:/usr/sbin
ENV USER=root

EXPOSE 5454
ENTRYPOINT ["/notifiarr"]

LABEL org.opencontainers.image.title="Notifiarr" \
      org.opencontainers.image.description="Notifiarr app" \
      org.opencontainers.image.source="https://github.com/nyok92/hassio-addons/notifiarr" \
      org.opencontainers.image.licenses="Apache-2.0"
