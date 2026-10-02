ARG BUILD_FROM=ghcr.io/home-assistant/base:latest
FROM $BUILD_FROM
ENV LANG C.UTF-8
COPY run.sh /
WORKDIR /data
RUN chmod a+x /run.sh

LABEL  org.opencontainers.image.title: "hassosenablessh addon"
LABEL  org.opencontainers.image.description: "hassosenablesshadd-on"
LABEL  org.opencontainers.image.source: "https://github.com/nyok92/hassio-addons/hassosenablessh"
LABEL  org.opencontainers.image.licenses: "Apache License 2.0"

CMD [ "/run.sh" ]
