FROM php:7.2-apache
# Update image
RUN apt-get update && apt-get install -y \
        curl \
        wget \
        git \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv mbstring mysqli pdo_mysql zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
# Install Xdebug
RUN pecl install xdebug-2.6.0alpha1




# Copy php.ini into image
RUN chown -R www-data:www-data /var/www/html
RUN usermod -u 1000 www-data
RUN usermod -G staff www-data

COPY ./upload/php.ini /usr/local/etc/php/php.ini