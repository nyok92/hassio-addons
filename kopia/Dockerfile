ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8
ARG BUILD_ARCH
ARG PACKAGEPLATFORM
ARG APP_VERSION

RUN apk add --no-cache \
    curl \
    tar \
    fuse3 \
    ca-certificates \
    tzdata \
    openssl \
    docker-cli \
    findutils \
    rclone \
    sqlite \
    nginx

ENV TERM="xterm-256color" \
  LC_ALL="C.UTF-8" \
  KOPIA_CONFIG_PATH=/config/config/repository.config \
  KOPIA_LOG_DIR=/config/logs \
  KOPIA_CACHE_DIRECTORY=/config/cache \
  RCLONE_CONFIG=/config/rclone/rclone.conf \
  KOPIA_PERSIST_CREDENTIALS_ON_CONNECT=false \
  KOPIA_CHECK_FOR_UPDATES=false \
  PATH="/app/kopia:$PATH"

RUN PACKAGEPLATFORM=$(case ${BUILD_ARCH} in \
        "amd64")        echo "x64"    ;; \
        "i386")         echo "i386"   ;; \
        "aarch64")      echo "arm64"  ;; \
        "armv7")        echo "arm"    ;; \
        "armhf")        echo "arm"    ;; \
        *)              echo ""       ;; esac) && \
    echo "platform ${PACKAGEPLATFORM} build arch ${BUILD_ARCH}"

#RUN export PACKAGEPLATFORM=$(case $TARGETARCH in "amd64") echo "x64" ;; "aarch64") echo "arm64" ;; "armv7") echo "arm" ;; "armhf") echo "arm" ;; "i386") echo "i386" ;; *) echo "unsupported_arch";; esac)

RUN \
  echo "**** install kopia ****" && \
  APP_VERSION=$(curl -s https://api.github.com/repos/kopia/kopia/releases/latest \
    | awk '/tag_name/{print $4;exit}' FS='[""]'); && \
  echo "APP_VERSION=${APP_VERSION}"

RUN mkdir -p /app/kopia && \
  curl -o \
    /tmp/kopia.tar.gz -L \
    "https://github.com/kopia/kopia/releases/download/${APP_VERSION}/kopia-${APP_VERSION#v}-linux-${PACKAGEPLATFORM}.tar.gz" && \
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
RUN chmod a+x /etc/s6-overlay/s6-rc.d/svc-kopia/data/check

ENTRYPOINT [ "/init" ]
CMD []
