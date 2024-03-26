ARG BUILD_FROM
FROM $BUILD_FROM

# Set to actual USR_ID and GRP_ID of the user this should run under
# Uses root by default, unless changed
ENV USR_ID=0 \
    GRP_ID=0 
ENV TZ="Europe/Paris"
ENV APP_DIR="/app" CONFIG_DIR="/config" CACHE_DIR="/cache" LOGS_DIR="/logs"

# make folders
RUN mkdir "${APP_DIR}" && \
    mkdir "${CONFIG_DIR}" && \
    mkdir "${CACHE_DIR}" && \
    mkdir "${LOGS_DIR}"

ARG TARGETARCH
ARG DUPLICACY_WEB_VERSION=1.8.0

# Installing software
RUN apk --update add --no-cache bash ca-certificates dbus tzdata nginx                                      &&  \
    export DUPLICACY_ARCH=$(case $TARGETARCH in "amd64") echo "x64" ;; "arm") echo "arm" ;; "arm64") echo "arm64" ;; *) echo "unsupported_arch";; esac) && \    
    export DUPLICACY_URL=https://acrosync.com/duplicacy-web/duplicacy_web_linux_${DUPLICACY_ARCH}_${DUPLICACY_WEB_VERSION} && \
    echo "Fetching duplicacy binary from ${DUPLICACY_URL}"                                                      && \
    wget -nv -O /usr/local/bin/duplicacy_web  ${DUPLICACY_URL} 2>&1                                             && \
    chmod +x /usr/local/bin/duplicacy_web                                                                       && \
    rm -f /var/lib/dbus/machine-id && ln -s /config/machine-id /var/lib/dbus/machine-id

# Copy root filesystem
COPY rootfs /
RUN chmod a+x /etc/s6-overlay/s6-rc.d/init-setup-app/run
RUN chmod a+x /etc/s6-overlay/s6-rc.d/service-duplicacy/run

ENTRYPOINT [ "/init" ]
CMD []
