ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apk add --no-cache ca-certificates curl tzdata

ENV APP_DIR="/app" CONFIG_DIR="/config" USER="duplicacy" PUID="1000" PGID="1000" UMASK="002" TZ="Etc/UTC"

# make folders
RUN mkdir "${APP_DIR}" && \
    mkdir "${CONFIG_DIR}"
# create user
RUN adduser -u $PUID -d "${CONFIG_DIR}" -s /bin/false duplicacy && \
    adduser -G users $USER

RUN mkdir "/var/lib/dbus" && ln -s "${CONFIG_DIR}/machine-id" "/var/lib/dbus/machine-id" && \
    ln -s "${CONFIG_DIR}/" "${APP_DIR}/.duplicacy-web"

# Install duplicacy web    
ENV PACKAGE="gilbertchen/duplicacy"
ARG VERSION
ARG BUILD_ARCH

RUN echo "**** install security fix packages ****" && \
    echo "**** download ${PACKAGE} ****" && \
    PACKAGEPLATFORM=$(case ${BUILD_ARCH} in \
        "amd64")        echo "x64"    ;; \
        "i386")         echo "i386"   ;; \
        "aarch64")      echo "arm64"  ;; \
        "armv7")        echo "arm"    ;; \
        "armhf")        echo "arm"    ;; \
        *)              echo ""       ;; esac) && \
    echo "Package ${PACKAGE} platform ${PACKAGEPLATFORM} version ${VERSION} build arch ${BUILD_ARCH}" && \
#    wget -q "https://acrosync.com/duplicacy-web/duplicacy_web_linux_${PACKAGEPLATFORM}_${VERSION}" -q0 /tmp/duplicacy
    curl -fsSL "https://acrosync.com/duplicacy-web/duplicacy_web_linux_${PACKAGEPLATFORM}_${VERSION}" > "${APP_DIR}/duplicacy_web" && \
    chmod 755 "${APP_DIR}/duplicacy_web"

# Copy root filesystem
COPY rootfs /
RUN chmod a+x /etc/s6-overlay/s6-rc.d/init-setup-app/run
RUN chmod a+x /etc/s6-overlay/s6-rc.d/service-duplicacy/run

ENTRYPOINT [ "/init" ]
CMD []
