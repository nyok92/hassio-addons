# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Execute during the build of the image
ARG TEMPIO_VERSION BUILD_ARCH DUPLICATI_VERSION PACKAGEPLATFORM DATERELEASE

RUN \
    curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"

RUN if dpkg --print-foreign-architectures | grep -q armhf; then \
    dpkg --remove-architecture armhf; \
    fi

RUN apt-get update && apt-get install -y gnupg2 wget ca-certificates

#RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys A6A19B38D3D831EF  && \
#    echo "deb https://download.mono-project.com/repo/debian stable-bullseye main" | tee /etc/apt/sources.list.d/mono-official-stable.list

#RUN apt-get update && \
#    apt-get install mono-devel apt-transport-https nano git-core software-properties-common dirmngr -y

# DOWNLOAD FROM DUPLICATI
RUN PACKAGEPLATFORM=$(case ${BUILD_ARCH} in \
        "amd64")        echo "x64"    ;; \
        "aarch64")      echo "arm64"  ;; \
        "armv7")        echo "arm7"    ;; \
        "armhf")        echo "arm7"    ;; \
        *)              echo ""       ;; esac) && \
  echo "platform ${PACKAGEPLATFORM} build arch ${BUILD_ARCH}" && \
  wget https://updates.duplicati.com/beta/duplicati-${DUPLICATI_VERSION}_beta_${DATERELEASE}-linux-${PACKAGEPLATFORM}-gui.deb  && \
  apt install ./duplicati-${DUPLICATI_VERSION}_beta_${DATERELEASE}-linux-${PACKAGEPLATFORM}-gui.deb -y

# Copy root filesystem
COPY rootfs /
RUN chmod a+x /etc/s6-overlay/s6-rc.d/init-duplicati-config/run
RUN chmod a+x /etc/s6-overlay/s6-rc.d/duplicati/run

# Fix Backblaze B2 Cloud Storage
RUN rm -rf /usr/share/ca-certificates/mozilla/DST_Root_CA_X3.crt && \
    update-ca-certificates

ENTRYPOINT [ "/init" ]
CMD []
