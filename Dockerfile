FROM uselagoon/php-7.4-cli-drupal:latest

LABEL maintainer="marji@morpht.com"

USER root

RUN rm -rf /opt/drupal

RUN composer self-update --2

RUN apk --update add git

LABEL org.opencontainers.image.source="https://github.com/morpht/ci-php-7.4"
