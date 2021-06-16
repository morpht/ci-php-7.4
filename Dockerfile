FROM php:7.4.20-fpm-alpine3.13

LABEL maintainer="marji@morpht.com"
LABEL org.opencontainers.image.source="https://github.com/morpht/ci-php-7.4"

ENV COMPOSER_VERSION=2.0.14 \
  COMPOSER_HASH_SHA256=29454b41558968ca634bf5e2d4d07ff2275d91b637a76d7a05e6747d36dd3473

RUN apk add --no-cache --update git \
        bash \
        openssh-client \
        rsync \
    && rm -rf /var/cache/apk/* \
    && curl -L -o /usr/local/bin/composer https://github.com/composer/composer/releases/download/${COMPOSER_VERSION}/composer.phar \
    && echo "$COMPOSER_HASH_SHA256  /usr/local/bin/composer" | sha256sum -c \
    && chmod +x /usr/local/bin/composer

# Remove warning about running as root in composer
ENV COMPOSER_ALLOW_SUPERUSER=1
