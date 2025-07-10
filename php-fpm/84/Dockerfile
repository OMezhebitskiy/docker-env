FROM php:8.4-fpm

WORKDIR /var/www

COPY docker.conf /usr/local/etc/php-fpm.d/docker.conf
COPY cron-jobs /etc/cron.d/scheduler

RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libzip-dev unzip git curl libonig-dev \
    libssl-dev zip tzdata bash cron \
    pkg-config libicu-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql intl mysqli gd mbstring zip exif pcntl sockets \
    && docker-php-ext-enable mysqli \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer

RUN chmod 0644 /etc/cron.d/scheduler && crontab /etc/cron.d/scheduler \
    && touch /var/log/cron.log
