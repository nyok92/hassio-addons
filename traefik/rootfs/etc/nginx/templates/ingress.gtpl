server {
    listen {{ .interface }}:{{ .port }} default_server;
#    listen [::]:{{ .port }} default_server;

    include /etc/nginx/includes/server_params.conf;
    include /etc/nginx/includes/proxy_params.conf;

    location / {
#        allow   172.30.32.2;
#        deny    all;

        proxy_pass {{ .protocol }}://backend;
        sub_filter '/api' '/hassio/addon/f464254c_traefik/api';
        sub_filter_types application/javascript application/x-javascript text/javascript;
        sub_filter_once off;
    }
#    location /api {
     location ~ ^/hassio/addon/f464254c_traefik/.*/api$ { 
        proxy_pass http://localhost:8080/api;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
#        allow   172.30.32.2;
#        deny    all;
    }
}
