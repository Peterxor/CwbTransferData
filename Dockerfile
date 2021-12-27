FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y vim \
    nginx \
    php-fpm \
    php-mysql \
    php-xml \
    curl \
    php-cli \
    php-mbstring \
    git \
    unzip \
    php-curl

RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Configure nginx
COPY ./deploy-setting/nginx/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY ./deploy-setting/php-fpm/www.conf /etc/php/7.0/fpm/pool.d/www.conf
COPY ./deploy-setting/php-fpm/php.ini /etc/php/7.0/fpm/php.ini


WORKDIR /var/www
COPY . /var/www

#CMD ["sh","init.sh"]