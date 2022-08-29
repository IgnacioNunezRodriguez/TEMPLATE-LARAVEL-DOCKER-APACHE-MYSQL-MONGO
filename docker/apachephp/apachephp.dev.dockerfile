FROM php:8.1-apache

RUN apt update && apt-get install -y \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libcurl4-openssl-dev \
    pkg-config \
    libssl-dev

COPY 00.apachecommonconfig/virtualhost.conf /etc/apache2/sites-available/virtualhost.conf
COPY 00.apachecommonconfig/apache2.conf /etc/apache2/apache2.conf
COPY 00.apachecommonconfig/php.ini-development /usr/local/etc/php/php.ini
COPY 00.apachecommonconfig/xdebug.orig.ini /usr/local/etc/php/conf.d/xdebug.orig.ini

RUN pecl install -f xdebug && docker-php-ext-enable xdebug

RUN cat /usr/local/etc/php/conf.d/xdebug.orig.ini >> /usr/local/etc/php/conf.d/docker-php-ext-debug.ini \
    && rm /usr/local/etc/php/conf.d/xdebug.orig.ini \
    && rm /etc/apache2/sites-available/000-default.conf

RUN apt clean && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install pdo pdo_mysql mysqli mbstring exif pcntl bcmath gd ctype fileinfo \
    && pecl install mongodb \
    && echo "extension=mongodb.so" > $PHP_INI_DIR/conf.d/mongo.ini


RUN a2enmod vhost_alias \
    && a2enmod rewrite \
    && a2enmod headers \
    && a2ensite virtualhost.conf

EXPOSE 80 9001
RUN useradd -G www-data,root --uid 1000 -d /home/userdev userdev \
    && mkdir -p /home/userdev/.composer \
    && chown -R userdev:userdev /home/userdev