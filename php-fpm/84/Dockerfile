FROM php:8.4-fpm

WORKDIR /var/www

RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libzip-dev unzip git curl libonig-dev \
    supervisor \
    libssl-dev zip tzdata bash cron \
    pkg-config libicu-dev \
    libpq-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql intl mysqli gd mbstring zip exif pcntl sockets \
    && docker-php-ext-enable mysqli \
    && pecl install redis xdebug \
    && docker-php-ext-enable redis xdebug \
    && curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer

COPY supervisord.conf /etc/supervisord.conf
COPY docker.conf /usr/local/etc/php-fpm.d/docker.conf
COPY cron-jobs /etc/cron.d/scheduler
COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

RUN chmod 0644 /etc/cron.d/scheduler && crontab /etc/cron.d/scheduler \
    && touch /var/log/cron.log

COPY entrypoint.sh /usr/local/bin/start
RUN chmod +x /usr/local/bin/start

CMD ["/usr/local/bin/start"]