FROM php:8.1-fpm-alpine

WORKDIR /var/www

COPY supervisord.conf /etc/supervisord.conf
COPY docker.conf /usr/local/etc/php-fpm.d/docker.conf
COPY cron-jobs /etc/cron.d/scheduler


RUN apk update && apk add --no-cache \
    imagemagick imagemagick-dev \
    autoconf g++ make\
    lz4-dev zstd-dev liblzf-dev \
    linux-headers \
    supervisor \
    oniguruma-dev \
    libzip-dev \
    zlib-dev \
    icu-dev \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    git \
    curl \
    gnupg \
    unzip \
    libevent \
    openssl \
    openssl-dev \
    zip \
    coreutils \
    tzdata \
    cronie \
    bash \
    imap-dev \
    krb5-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install pdo pdo_mysql intl mysqli gd mbstring zip exif pcntl sockets imap \
    && docker-php-ext-enable mysqli imap \
    && pecl install igbinary msgpack redis imagick \
    && docker-php-ext-enable redis igbinary msgpack imagick \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer

RUN chmod 0644 /etc/cron.d/scheduler && crontab /etc/cron.d/scheduler \
    && touch /var/log/cron.log

COPY entrypoint.sh /usr/local/bin/start
RUN chmod +x /usr/local/bin/start

CMD ["/usr/local/bin/start"]