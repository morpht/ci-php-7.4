FROM php:7.4.33-fpm-alpine3.16

LABEL maintainer="marji@morpht.com"
LABEL org.opencontainers.image.source="https://github.com/morpht/ci-php-7.4"

ENV COMPOSER_VERSION=2.4.4 \
  COMPOSER_HASH_SHA256=c252c2a2219956f88089ffc242b42c8cb9300a368fd3890d63940e4fc9652345

RUN apk add --no-cache --update git \
        bash \
        openssh-client \
        mysql-client \
        patch \
        rsync \
        libpng libpng-dev libzip-dev \
    && docker-php-ext-install gd pdo pdo_mysql zip \
    && apk del libpng-dev \
    && rm -rf /var/cache/apk/* \
    && curl -L -o /usr/local/bin/composer https://github.com/composer/composer/releases/download/${COMPOSER_VERSION}/composer.phar \
    && echo "$COMPOSER_HASH_SHA256  /usr/local/bin/composer" | sha256sum -c \
    && chmod +x /usr/local/bin/composer

# Remove warning about running as root in composer
ENV COMPOSER_ALLOW_SUPERUSER=1
