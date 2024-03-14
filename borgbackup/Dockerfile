ARG BUILD_FROM
FROM $BUILD_FROM

LABEL org.opencontainers.image.source=https://github.com/nyok92/hassio-addons/borgbackup
ENV LANG C.UTF-8

RUN apk add --no-cache \
        borgbackup \
        openssh-keygen \
        openssh-client

# Home Assistant CLI
ARG BUILD_ARCH
ARG CLI_VERSION
RUN curl -Lso /usr/bin/ha \
        "https://github.com/home-assistant/cli/releases/download/${CLI_VERSION}/ha_${BUILD_ARCH}" \
    && chmod a+x /usr/bin/ha 

# Copy root filesystem
COPY rootfs /
RUN chmod a+x /usr/bin/run.sh
RUN chmod a+x /usr/bin/backup.sh

ENTRYPOINT [ "/init" ]
CMD []
