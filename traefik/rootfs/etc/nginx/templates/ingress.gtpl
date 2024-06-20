server {
    listen {{ .interface }}:{{ .port }} default_server;
#    listen [::]:{{ .port }} default_server;

    include /etc/nginx/includes/server_params.conf;
    include /etc/nginx/includes/proxy_params.conf;

    location / {
#        allow   172.30.32.2;
#        deny    all;

        proxy_pass {{ .protocol }}://backend;
#        sub_filter '/api' '../test/api';
#        sub_filter_types application/javascript application/x-javascript text/javascript;
#        sub_filter_once off;
    }
    location /api {
        proxy_pass {{ .protocol }}://backend/api;
#        allow   172.30.32.2;
#        deny    all;
    }
}
