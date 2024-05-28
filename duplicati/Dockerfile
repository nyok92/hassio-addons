# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Execute during the build of the image
ARG BUILD_ARCH

ARG DUPLICATI_RELEASE

RUN \
  curl -o \
    /etc/apk/keys/ig.rsa.pub \
    "https://packages.imagegenius.io/ig.rsa.pub" && \
  echo "https://packages.imagegenius.io/v3.18/" >>/etc/apk/repositories

RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    ca-certificates-mono \
    libgdiplus \
    mono-reference-assemblies-facades \
    rclone \
    sqlite-libs \
    terminus-font && \
  echo "**** install duplicati ****" && \
  mkdir -p /app/duplicati && \
  if [ -z ${DUPLICATI_RELEASE} ]; then \
    DUPLICATI_RELEASE=$(curl -sL "https://api.github.com/repos/duplicati/duplicati/releases" | \
      jq -r 'first(.[] | select(.tag_name | contains("beta"))) | .tag_name'); \
  fi && \
  curl -o \
    /tmp/duplicati.zip -L \
    "$(curl -s https://api.github.com/repos/duplicati/duplicati/releases/tags/${DUPLICATI_RELEASE} | \
      jq -r '.assets[].browser_download_url' | grep '.zip$' | grep -v signatures)" && \
  unzip \
    /tmp/duplicati.zip -d \
    /app/duplicati && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

# Copy root filesystem
COPY rootfs /
RUN chmod a+x /usr/bin/run_duplicati

#ENTRYPOINT [ "/init" ]
#CMD []
