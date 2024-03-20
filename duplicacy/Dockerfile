ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apk add curl

# Copy root filesystem
COPY rootfs /
RUN chmod a+x /etc/s6-overlay/s6-rc.d/init-setup-app/run
RUN chmod a+x /etc/s6-overlay/s6-rc.d/service-duplicacy/run

ARG CONFIG_DIR
ARG APP_DIR
RUN mkdir "/var/lib/dbus" && ln -s "${CONFIG_DIR}/machine-id" "/var/lib/dbus/machine-id" && \
    ln -s "${CONFIG_DIR}/" "${APP_DIR}/.duplicacy-web"

ARG VERSION
RUN curl -fsSL "https://acrosync.com/duplicacy-web/duplicacy_web_linux_x64_${VERSION}" > "${APP_DIR}/duplicacy_web" && \
    chmod 755 "${APP_DIR}/duplicacy_web

ENTRYPOINT [ "/init" ]
CMD []
