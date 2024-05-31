ARG BUILD_FROM
FROM $BUILD_FROM

#ENV APP_DIR="/app" CONFIG_DIR="/config" CACHE_DIR="/cache" LOGS_DIR="/logs"

# make folders
#RUN mkdir "${APP_DIR}" && \
#    mkdir "${CONFIG_DIR}" && \
#    mkdir "${CACHE_DIR}" && \
#    mkdir "${LOGS_DIR}"

# Installing software
RUN apk --update add --no-cache bash jq curl wget ca-certificates dbus tzdata nginx && \
    rm -f /var/lib/dbus/machine-id && ln -s /config/machine-id /var/lib/dbus/machine-id 

# Copy root filesystem
COPY rootfs /
RUN chmod a+x /etc/s6-overlay/s6-rc.d/init-setup-app/run && \
    chmod a+x /etc/s6-overlay/s6-rc.d/service-duplicacy/run

# Copy mqtt-inteegrtion python scripts
RUN mkdir mqtt-integration
COPY mqtt-integration /mqtt-integration
RUN chmod a+x /mqtt-integration/duplicacy_runner.py && \
    chmod a+x /mqtt-integration/log_parser.py && \
    chmod a+x /mqtt-integration/state_types.py && \
    chmod a+x /mqtt-integration/update_handler.py && \
    chmod a+x /mqtt-integration/utils.py

ENTRYPOINT [ "/init" ]
CMD []
