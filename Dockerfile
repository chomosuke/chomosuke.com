FROM node:19 as react-builder
# install dependencies first
WORKDIR /pages/notfound
COPY ./pages/notfound/package-lock.json ./pages/notfound/package.json ./
RUN npm ci
# copy app and build
WORKDIR /pages/notfound
COPY ./pages/notfound ./
RUN npm run build

FROM jonasal/nginx-certbot:4-alpine
# set up nginx
ENV CERTBOT_AUTHENTICATOR dns-route53
COPY ./nginx_conf.d /etc/nginx/user_conf.d/
# copy all pages
WORKDIR /www/pages
COPY --from=react-builder /pages/notfound/build ./notfound
