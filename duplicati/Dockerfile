# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Execute during the build of the image
ARG TEMPIO_VERSION BUILD_ARCH DUPLICATI_RELEASE PACKAGEPLATFORM

RUN \
    curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"

# DOWNLOAD FROM DUPLICATI
RUN PACKAGEPLATFORM=$(case ${BUILD_ARCH} in \
        "amd64")        echo "x64"    ;; \
        "aarch64")      echo "arm64"  ;; \
        "armv7")        echo "arm7"    ;; \
        "armhf")        echo "armhf"    ;; \
        *)              echo ""       ;; esac) && \
  echo "platform ${PACKAGEPLATFORM} build arch ${BUILD_ARCH}"

RUN \
  echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections && \
  apt-add-repository contrib non-free -y && \
  apt-get update && \
  apt-get install -y \
    software-properties-common \
#    libicu74 \
    libicu-dev \
    ttf-mscorefonts-installer \
    unzip && \
  echo "**** install duplicati ****" && \
  if [ -z ${DUPLICATI_RELEASE+x} ]; then \
    DUPLICATI_RELEASE=$(curl -sX GET "https://api.github.com/repos/duplicati/duplicati/releases" \
      | jq -r 'first(.[] | select(.tag_name | contains("beta"))) | .tag_name'); \
  fi && \
  duplicati_url=$(curl -s "https://api.github.com/repos/duplicati/duplicati/releases/tags/${DUPLICATI_RELEASE}" | jq -r '.assets[].browser_download_url' |grep 'linux-${PACKAGEPLATFORM}-gui.zip$') && \
  curl -o \
    /tmp/duplicati.zip -L \
    "${duplicati_url}" && \
  unzip -q /tmp/duplicati.zip -d /app && \
  mv /app/duplicati* /app/duplicati && \
  printf "Linuxserver.io version: ${VERSION}\nBuild-date: ${BUILD_DATE}" > /build_version && \
  echo "**** cleanup ****" && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# Copy root filesystem
COPY rootfs /
RUN chmod a+x /etc/s6-overlay/s6-rc.d/init-duplicati-config/run
RUN chmod a+x /etc/s6-overlay/s6-rc.d/duplicati/run

ENTRYPOINT [ "/init" ]
CMD []
