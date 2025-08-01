server {
#    listen {{ .interface }}:{{ .port }} default_server;
    listen {{ .interface }}:8099 default_server;
#    listen {{ .interface }}:{{ .port }} proxy_protocol;
    listen [::]:8099 default_server;

# proxy protocol
#    set_real_ip_from 192.168.1.0/24;
#    real_ip_header proxy_protocol;
#    proxy_protocol      on;

    include /etc/nginx/includes/server_params.conf;
    include /etc/nginx/includes/proxy_params.conf;

#    location /dashboard/ {
#        allow   172.30.32.2;
#        deny    all;
#        proxy_pass {{ .protocol }}://backend/dashboard/;
#
#        sub_filter '/api' '/hassio/addon/f464254c_traefik/api';
#        sub_filter '/api' '../api';
#        sub_filter_types application/javascript application/x-javascript text/javascript;
#        sub_filter_once off;
#    }

#    location /api {
#    location ~ ^/hassio/addon/f464254c_traefik/.*/api$ { 
#    location ~* /hassio/addon/f464254c_traefik/(?<variable>.*)/api$ {
#        allow   172.30.32.2;
#        deny    all;
#        proxy_pass {{ .protocol }}://backend/api;
#        proxy_set_header Host $host;
#        proxy_set_header X-Forwarded-Scheme $scheme;
#        proxy_set_header X-Forwarded-Proto  $scheme;
#        proxy_set_header X-Forwarded-For    $remote_addr;
#        proxy_set_header X-Real-IP		$remote_addr;
#        proxy_set_header Upgrade $http_upgrade;
#        proxy_set_header Connection $http_connection;
#        proxy_http_version 1.1;
#    }
    location /dashboard/ {
        proxy_pass http://localhost:8080/dashboard/;
        
        sub_filter '/api' '../api';
        sub_filter_types application/javascript application/x-javascript text/javascript;
        sub_filter_once off;
    }

    location /api {
        proxy_pass http://localhost:8080/api;
    }
}
