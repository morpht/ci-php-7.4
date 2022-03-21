FROM php:7.4.28-fpm-alpine3.14

LABEL maintainer="marji@morpht.com"
LABEL org.opencontainers.image.source="https://github.com/morpht/ci-php-7.4"

ENV COMPOSER_VERSION=2.2.9 \
  COMPOSER_HASH_SHA256=48f9fdc9ad93904fee96550b45ae03a51f69718502ee855da894b4ad71d2dfe0

RUN apk add --no-cache --update git \
        bash \
        openssh-client \
        mysql-client \
        patch \
        rsync \
        libpng libpng-dev \
    && docker-php-ext-install gd pdo pdo_mysql \
    && apk del libpng-dev \
    && rm -rf /var/cache/apk/* \
    && curl -L -o /usr/local/bin/composer https://github.com/composer/composer/releases/download/${COMPOSER_VERSION}/composer.phar \
    && echo "$COMPOSER_HASH_SHA256  /usr/local/bin/composer" | sha256sum -c \
    && chmod +x /usr/local/bin/composer

# Remove warning about running as root in composer
ENV COMPOSER_ALLOW_SUPERUSER=1
