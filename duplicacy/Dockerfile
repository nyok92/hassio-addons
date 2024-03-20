ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apk add curl

ARG CONFIG_DIR
ARG APP_DIR
RUN mkdir "/var/lib/dbus" && ln -s "${CONFIG_DIR}/machine-id" "/var/lib/dbus/machine-id" && \
    ln -s "${CONFIG_DIR}/" "${APP_DIR}/.duplicacy-web"

# Install dupliccay web    
ENV PACKAGE="gilbertchen/duplicacy"
ARG VERSION
ARG TARGETPLATFORM
ARG BUILD_ARCH

RUN echo "**** install security fix packages ****" && \
    echo "**** download ${PACKAGE} ****" && \
    PACKAGEPLATFORM=$(case ${TARGETPLATFORM} in \
        "linux/amd64")  echo "x64"    ;; \
        "linux/386")    echo "i386"   ;; \
        "linux/arm64")  echo "arm64"  ;; \
        "linux/arm/v7") echo "arm"    ;; \
        "linux/arm/v6") echo "arm"    ;; \
        *)              echo ""       ;; esac) && \
    echo "Package ${PACKAGE} platform ${PACKAGEPLATFORM} version ${VERSION} build arch ${BUILD_ARCH}" && \
#    wget -q "https://acrosync.com/duplicacy-web/duplicacy_web_linux_${PACKAGEPLATFORM}_${VERSION}" -q0 /tmp/duplicacy
    curl -fsSL "https://acrosync.com/duplicacy-web/duplicacy_web_linux_${PACKAGEPLATFORM}_${VERSION}" > "${APP_DIR}/duplicacy_web" && \
    chmod 755 "${APP_DIR}/duplicacy_web

# Copy root filesystem
COPY rootfs /
RUN chmod a+x /etc/s6-overlay/s6-rc.d/init-setup-app/run
RUN chmod a+x /etc/s6-overlay/s6-rc.d/service-duplicacy/run

ENTRYPOINT [ "/init" ]
CMD []
