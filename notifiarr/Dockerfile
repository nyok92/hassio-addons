ARG BUILD_FROM=ghcr.io/Notifiarr/notifiarr:latest
FROM $BUILD_FROM

ENV TZ=UTC
ENV PATH=/bin:/usr/bin:/sbin:/usr/sbin
ENV USER=root

EXPOSE 5454
ENTRYPOINT ["/notifiarr"]
