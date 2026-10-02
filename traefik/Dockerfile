ARG BUILD_FROM=ghcr.io/home-assistant/base:latest
FROM $BUILD_FROM

ARG BUILD_ARCH
ARG TRAEFIK_VERSION=3.7.13

RUN case "${BUILD_ARCH}" in \
        aarch64) TRAEFIK_ARCH="arm64" ;; \
        amd64)   TRAEFIK_ARCH="amd64" ;; \
        *) echo "Unsupported arch: ${BUILD_ARCH}" >&2; exit 1 ;; \
    esac && \
    apk add --no-cache \
        nginx \
        yq-go \
        gomplate && \
    wget -q -O /tmp/traefik.tar.gz \
        "https://github.com/traefik/traefik/releases/download/v${TRAEFIK_VERSION}/traefik_v${TRAEFIK_VERSION}_linux_${TRAEFIK_ARCH}.tar.gz" && \
    tar -xzf /tmp/traefik.tar.gz -C /usr/local/bin traefik && \
    chmod +x /usr/local/bin/traefik && \
    rm -rf /etc/nginx /tmp/*

COPY rootfs /
RUN chmod a+x \
    /etc/s6-overlay/s6-rc.d/init-traefik-config/run \
    /etc/s6-overlay/s6-rc.d/traefik/run \
    /etc/s6-overlay/s6-rc.d/init-nginx/run \
    /etc/s6-overlay/s6-rc.d/nginx/run

LABEL org.opencontainers.image.title="Traefik addon" \
      org.opencontainers.image.description="Traefik add-on" \
      org.opencontainers.image.source="https://github.com/nyok92/hassio-addons/traefik" \
      org.opencontainers.image.licenses="Apache-2.0"

ENTRYPOINT [ "/init" ]
CMD []
