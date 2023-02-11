FROM php:8-cli as base

RUN apt-get update && apt-get install -y \
    libpq-dev \
    git \
    unzip

RUN pecl channel-update pecl.php.net

FROM base as development

ARG IP
ENV IP=${IP}

RUN apt-get update && apt-get install -y \
    build-essential \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_host=$IP" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

EXPOSE 9003

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
