FROM uselagoon/php-7.4-cli-drupal:latest

LABEL maintainer="marji@morpht.com"
LABEL org.opencontainers.image.source="https://github.com/morpht/ci-php-7.4"

RUN rm -rf /opt/drupal \
  && composer self-update --2 \
  && apk --no-cache --update add git \
  && rm -rf /lagoon/entrypoints
