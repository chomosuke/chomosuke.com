FROM jonasal/nginx-certbot:4-alpine
ENV STAGING 1
ENV CERTBOT_AUTHENTICATOR dns-route53
COPY ./nginx_conf.d /etc/nginx/user_conf.d/
