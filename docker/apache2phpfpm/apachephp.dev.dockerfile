FROM httpd:alpine

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

COPY ../00.apachecommonconfig/virtualhost.conf /etc/apache2/sites-available/virtualhost.conf
COPY ../00.apachecommonconfig/apache2.conf /etc/apache2/apache2.conf
RUN rm /etc/apache2/sites-available/000-default.conf

RUN a2enmod vhost_alias
RUN a2enmod rewrite
RUN a2enmod headers

RUN a2ensite virtualhost.conf

EXPOSE 80
RUN useradd -G www-data,root --uid 1000 -d /home/userdev userdev
RUN mkdir -p /home/userdev/.composer && \
    chown -R userdev:userdev /home/userdev

