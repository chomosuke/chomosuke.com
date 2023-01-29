FROM jonasal/nginx-certbot:4-alpine
COPY ./nginx_conf.d /etc/nginx/user_conf.d/
