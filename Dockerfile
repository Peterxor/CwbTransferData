FROM ubuntu:16.04
ENV LANG=en_US.UTF-8
RUN apt-get update && \
    apt-get install -y vim \
    nginx \
    php-fpm \
    curl \
    supervisor \
    git \
    unzip \
    locales \
    apt-transport-https



# install sqlcmd
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

RUN apt-get update

RUN ACCEPT_EULA=Y apt-get install -y msodbcsql=13.0.1.0-1 mssql-tools=14.0.2.0-1
RUN apt-get install -y unixodbc-dev-utf16

RUN ln -sfn /opt/mssql-tools/bin/sqlcmd-13.0.1.0 /usr/bin/sqlcmd && \
    ln -sfn /opt/mssql-tools/bin/bcp-13.0.1.0 /usr/bin/bcp && \
    locale-gen en_US.UTF-8

# Configure nginx
COPY ./deploy-setting/nginx/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY ./deploy-setting/php-fpm/www.conf /etc/php/7.0/fpm/pool.d/www.conf
COPY ./deploy-setting/php-fpm/php.ini /etc/php/7.0/fpm/php.ini

# Configure supervisor
COPY ./deploy-setting/supervisor/conf.d/nginx.conf /etc/supervisor/conf.d/nginx.conf
COPY ./deploy-setting/supervisor/conf.d/php-fpm.conf /etc/supervisor/conf.d/php-fpm.conf
COPY ./deploy-setting/supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /var/www
COPY . /var/www

CMD [ "sh", "-c", "service supervisor start;"]



