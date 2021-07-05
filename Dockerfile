FROM php:7.4.20-fpm-alpine3.13

LABEL maintainer="marji@morpht.com"
LABEL org.opencontainers.image.source="https://github.com/morpht/ci-php-7.4"

ENV COMPOSER_VERSION=2.1.3 \
  COMPOSER_HASH_SHA256=f8a72e98dec8da736d8dac66761ca0a8fbde913753e9a43f34112367f5174d11

RUN apk add --no-cache --update git \
        bash \
        openssh-client \
        patch \
        rsync \
        libpng libpng-dev \
    && docker-php-ext-install gd \
    && apk del libpng-dev \
    && rm -rf /var/cache/apk/* \
    && curl -L -o /usr/local/bin/composer https://github.com/composer/composer/releases/download/${COMPOSER_VERSION}/composer.phar \
    && echo "$COMPOSER_HASH_SHA256  /usr/local/bin/composer" | sha256sum -c \
    && chmod +x /usr/local/bin/composer

# Remove warning about running as root in composer
ENV COMPOSER_ALLOW_SUPERUSER=1
