FROM php:8.4-fpm

LABEL image-name="development"

# Install dependencies for the operating system software
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    libzip-dev \
    unzip \
    git \
    libonig-dev \
    curl \
    libicu-dev \
    libxml2-dev \
    mariadb-client \
    supervisor \
    nano \
    procps

# Install extensions for php
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl
RUN docker-php-ext-install soap
RUN docker-php-ext-install bcmath

# Install APCu extension for PHP
RUN apt-get update && apt-get install -y libpcre3-dev gcc make autoconf libc-dev pkg-config \
    && pecl install apcu \
    && docker-php-ext-enable apcu

# install & enable xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install composer (php package manager)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www/

COPY ./php.ini "$PHP_INI_DIR/conf.d/php.ini"

# Install supervisor
COPY supervisor/conf.d /etc/supervisor/conf.d/

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

# Expose port 9000 and start php-fpm server (for FastCGI Process Manager)
EXPOSE 9000
CMD ["php-fpm"]
