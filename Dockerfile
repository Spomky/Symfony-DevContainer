FROM php:8.5-cli

# Dependencies
RUN apt-get update \
    && apt-get install -y \
        git \
        libicu-dev \
        libpq-dev \
        libzip-dev \
        unzip \
        wget \
        zip \
        curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# PHP Extensions
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions \
    amqp \
    apcu \
    brotli \
    exif \
    fileinfo \
    gd \
    gettext \
    gmp \
    iconv \
    imagick \
    intl \
    opcache \
    pdo_pgsql \
    pdo_sqlite \
    redis \
    sodium \
    uuid \
    xdebug \
    xml \
    xsl \
    zip \
    zstd

# Xdebug configuration
RUN echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_port=9003" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Symfony CLI
RUN wget https://get.symfony.com/cli/installer -O - | bash \
    && mv /root/.symfony*/bin/symfony /usr/local/bin/symfony

# Castor
RUN curl "https://castor.jolicode.com/install" | bash \
    && mv /root/.local/bin/castor /usr/local/bin/castor

# Working directory
WORKDIR /workspace