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

COPY ./docker/00.apachecommonconfig/apache2.conf /etc/apache2/apache2.conf
COPY ./docker/00.apachecommonconfig/php.ini-production /usr/local/etc/php/php.ini
COPY ./docker/00.apachecommonconfig/virtualhost.conf /etc/apache2/sites-available/virtualhost.conf


RUN rm /etc/apache2/sites-available/000-default.conf \
    && docker-php-ext-install pdo pdo_mysql mysqli mbstring exif pcntl bcmath gd ctype fileinfo xml curl fileinfo \
    && pecl install mongodb \
    &&  echo "extension=mongodb.so" > $PHP_INI_DIR/conf.d/mongo.ini \
    && apt clean && rm -rf /var/lib/apt/lists/* \
    && a2enmod vhost_alias \
    && a2enmod rewrite \
    && a2enmod headers \
    && a2ensite virtualhost.conf

EXPOSE 80
RUN useradd -G www-data,root --uid 1000 -d /home/user user \
    && mkdir -p /home/user \
    && chown -R user:user /home/user 
COPY ./src /var/www/html

RUN /usr/local/bin/php /var/www/html/artisan config:cache \
    && /usr/local/bin/php /var/www/html/artisan route:cache \
    && /usr/local/bin/php /var/www/html/artisan view:cache \
    && cp pro.env .env \
    && rm pro.env