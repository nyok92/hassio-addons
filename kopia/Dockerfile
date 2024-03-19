ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apk add curl

# Home Assistant CLI
ARG BUILD_ARCH
ARG CLI_VERSION
RUN curl -Lso /usr/bin/ha \
        "https://github.com/home-assistant/cli/releases/download/${CLI_VERSION}/ha_${BUILD_ARCH}" \
    && chmod a+x /usr/bin/ha 

ENV TERM="xterm-256color" \
  LC_ALL="C.UTF-8" \
  KOPIA_CONFIG_PATH=/config/config/repository.config \
  KOPIA_LOG_DIR=/config/logs \
  KOPIA_CACHE_DIRECTORY=/config/cache \
  RCLONE_CONFIG=/config/rclone/rclone.conf \
  KOPIA_PERSIST_CREDENTIALS_ON_CONNECT=false \
  KOPIA_CHECK_FOR_UPDATES=false \
  PATH="/app/kopia:$PATH"
ARG APP_VERSION
RUN \
  echo "**** install packages ****" && \
  apk add  --no-cache \
    docker-cli \
    findutils \
    fuse \
    openssl \
    rclone \
    sqlite && \
  echo "**** install kopia ****" && \
  if [ -z ${APP_VERSION+x} ]; then \
    APP_VERSION=$(curl -s https://api.github.com/repos/kopia/kopia/releases/latest \
    | awk '/tag_name/{print $4;exit}' FS='[""]'); \
  fi && \
  mkdir -p /app/kopia && \
  curl -o \
    /tmp/kopia.tar.gz -L \
    "https://github.com/kopia/kopia/releases/download/${APP_VERSION}/kopia-${APP_VERSION#v}-linux-arm64.tar.gz" && \
  tar xf \
    /tmp/kopia.tar.gz -C \
    /app/kopia --strip-components=1 && \
  echo "**** cleanup ****" && \
  rm -rf \
    $HOME/.cache \
    /tmp/*

# copy local files
COPY rootfs/ /

# ports and volumes
EXPOSE 51515

VOLUME /config

ENTRYPOINT [ "/init" ]
CMD []
