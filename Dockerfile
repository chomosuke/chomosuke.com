FROM jonasal/nginx-certbot:4-alpine
ENV STAGING 1
RUN echo 'Can run in arm64'
COPY ./nginx_conf.d /etc/nginx/user_conf.d/
COPY ./dhparam.pem /etc/letsencrypt/dhparams/dhparam.pem
