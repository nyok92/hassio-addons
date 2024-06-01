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

# Copy mqtt-integration python scripts
COPY mqtt-integration /mqtt
RUN chmod a+x /mqtt/duplicacy_runner.py && \
    chmod a+x /mqtt/log_parser.py && \
    chmod a+x /mqtt/state_types.py && \
    chmod a+x /mqtt/update_handler.py && \
    chmod a+x /mqtt/utils.py
    
# Install python requirements
RUN pip install -r /mqtt/requirements.txt

ENTRYPOINT [ "/init" ]
CMD []
