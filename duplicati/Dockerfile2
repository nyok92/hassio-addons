# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Execute during the build of the image
ARG BUILD_ARCH MONO_VERSION

ARG DUPLICATI_RELEASE

# environment settings
#ENV HOME="/config"
#ENV DEBIAN_FRONTEND="noninteractive"

# install mono
RUN apt-get update
RUN apt install -y dirmngr ca-certificates gnupg && \
  gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/mono-official-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
  echo "deb [signed-by=/usr/share/keyrings/mono-official-archive-keyring.gpg] https://download.mono-project.com/repo/debian stable-buster main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
  apt update
RUN apt install -y \
    mono-devel \
    mono-vbnc \
    unzip

# install duplicati
RUN \
  echo "**** install duplicati ****" && \
  if [ -z ${DUPLICATI_RELEASE+x} ]; then \
    DUPLICATI_RELEASE=$(curl -sX GET "https://api.github.com/repos/duplicati/duplicati/releases" \
    | jq -r 'first(.[] | select(.tag_name | contains("beta"))) | .tag_name'); \
  fi && \
  mkdir -p \
    /app/duplicati && \
  duplicati_url=$(curl -s https://api.github.com/repos/duplicati/duplicati/releases/tags/"${DUPLICATI_RELEASE}" |jq -r '.assets[].browser_download_url' |grep '.zip$' |grep -v signatures) && \
  curl -o \
    /tmp/duplicati.zip -L \
    "${duplicati_url}" && \
  unzip -q /tmp/duplicati.zip -d /app/duplicati && \
  echo "**** cleanup ****" && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# Copy root filesystem
COPY rootfs /
RUN chmod a+x /usr/bin/run_duplicati

#ENTRYPOINT [ "/init" ]
#CMD []
