ARG BUILD_FROM=ghcr.io/home-assistant/base:latest
FROM $BUILD_FROM
ARG TRAEFIK_VERSION=3.7.13

RUN if [ "${BUILD_ARCH}" == "aarch64" ]; then BUILD_ARCH=arm64; \
    elif [ "${BUILD_ARCH}" == "amd64" ]; then BUILD_ARCH=amd64; \
    fi && \
    apk add --no-cache \
        nginx \
        yq-go \
        gomplate && \
    wget --quiet -O /tmp/traefik.tar.gz "https://github.com/traefik/traefik/releases/download/v${TRAEFIK_VERSION}/traefik_v${TRAEFIK_VERSION}_linux_${BUILD_ARCH}.tar.gz" && \
    tar xzvf /tmp/traefik.tar.gz -C /usr/local/bin traefik && \
    chmod +x /usr/local/bin/traefik && \
    rm -fr \
     /etc/nginx \
     /tmp/*

COPY rootfs /
RUN chmod a+x /etc/s6-overlay/s6-rc.d/init-traefik-config/run
RUN chmod a+x /etc/s6-overlay/s6-rc.d/traefik/run
RUN chmod a+x /etc/s6-overlay/s6-rc.d/init-nginx/run
RUN chmod a+x /etc/s6-overlay/s6-rc.d/nginx/run

LABEL  org.opencontainers.image.title: "Traefik addon"
LABEL  org.opencontainers.image.description: "Traefik add-on"
LABEL  org.opencontainers.image.source: "https://github.com/nyok92/hassio-addons/traefik"
LABEL  org.opencontainers.image.licenses: "Apache License 2.0"

ENTRYPOINT [ "/init" ]
CMD []
