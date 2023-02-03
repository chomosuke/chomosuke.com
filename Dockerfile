FROM node:19 as react-builder

# install dependencies first
WORKDIR /pages/home
COPY ./pages/home/package.json ./
COPY ./pages/home/package-lock.json ./
RUN npm ci
WORKDIR /pages/notfound
COPY ./pages/notfound/package.json ./
COPY ./pages/notfound/package-lock.json ./
RUN npm ci

# copy app and build
WORKDIR /pages/home
COPY ./pages/home ./
RUN npm run build
WORKDIR /pages/notfound
COPY ./pages/notfound ./
RUN npm run build


FROM debian:bullseye as flutter-builder

# set up flutter
RUN apt-get update && apt-get install -y curl git unzip xz-utils zip
USER root
WORKDIR /home/root
RUN git clone --depth 1 --branch stable https://github.com/flutter/flutter.git
ENV PATH $PATH:/home/root/flutter/bin
RUN flutter precache --web

# build all flutter pages
COPY ./pages/profile ./profile
WORKDIR /home/root/profile
RUN flutter build web


FROM jonasal/nginx-certbot:4-alpine

# set up nginx
ENV CERTBOT_AUTHENTICATOR dns-route53
COPY ./nginx_conf.d /etc/nginx/user_conf.d/

# copy all pages
WORKDIR /www/pages
COPY --from=react-builder /pages/home/build ./home
COPY --from=react-builder /pages/notfound/build ./notfound
COPY --from=flutter-builder /home/root/profile/build/web/ ./profile
