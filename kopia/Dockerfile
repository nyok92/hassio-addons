ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8
ARG APP_VERSION

RUN apk add curl

ENV TERM="xterm-256color" \
  LC_ALL="C.UTF-8" \
  KOPIA_CONFIG_PATH=/config/config/repository.config \
  KOPIA_LOG_DIR=/config/logs \
  KOPIA_CACHE_DIRECTORY=/config/cache \
  RCLONE_CONFIG=/config/rclone/rclone.conf \
  KOPIA_PERSIST_CREDENTIALS_ON_CONNECT=false \
  KOPIA_CHECK_FOR_UPDATES=false \
  PATH="/app/kopia:$PATH"

RUN \
  echo "**** install packages ****" && \
  apk add  --no-cache \
    fuse3 \
    ca-certificates \
    tzdata \
    openssl \
    docker-cli \
    findutils \
    rclone \
    sqlite
    
RUN \    
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

# copy local files & add scripts permission
COPY rootfs/ /
RUN chmod a+x /etc/s6-overlay/s6-rc.d/svc-kopia/run
RUN chmod a+x /etc/s6-overlay/s6-rc.d/init-kopia-config/run

ENTRYPOINT [ "/init" ]
CMD []
