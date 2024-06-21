server {
    listen {{ .interface }}:{{ .port }} default_server;
#    listen [::]:{{ .port }} default_server;

    include /etc/nginx/includes/server_params.conf;
    include /etc/nginx/includes/proxy_params.conf;

    location / {
#        allow   172.30.32.2;
#        deny    all;

        proxy_pass {{ .protocol }}://backend;
#        sub_filter '/api' '/hassio/addon/f464254c_traefik/api';
        sub_filter '/api' '/api';
        sub_filter_types application/javascript application/x-javascript text/javascript;
        sub_filter_once off;
    }
    location /api {
#        allow   172.30.32.2;
#        deny    all;
#     location ~ ^/hassio/addon/f464254c_traefik/.*/api$ { 
#    location ~* /hassio/addon/f464254c_traefik/(?<variable>.*)/api$ {
#        sub_filter '/api' '/hassio/addon/f464254c_traefik/api';
#        sub_filter '/api' '/api';
#        sub_filter_types application/javascript application/x-javascript text/javascript;
#        sub_filter_once off;
        proxy_pass {{ .protocol }}://backend/api;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Scheme $scheme;
        proxy_set_header X-Forwarded-Proto  $scheme;
        proxy_set_header X-Forwarded-For    $remote_addr;
        proxy_set_header X-Real-IP		$remote_addr;
    }
}
