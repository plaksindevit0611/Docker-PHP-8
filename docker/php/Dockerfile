FROM php:8.3-fpm

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
    supervisor

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions for php
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl
RUN docker-php-ext-install soap

# install & enable xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Install composer (php package manager)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www/

# Copy existing application directory contents to the working directory
COPY . /var/www

# Assign permissions of the working directory to the www-data user
RUN chown -R www-data:www-data /var/www

COPY ./php.ini "$PHP_INI_DIR/conf.d/php.ini"

#RUN rm -f /docker-entrypoint.sh && rm -f /usr/local/etc/php-fpm.d/*

#COPY ./supervisord.conf /etc/supervisord.conf
COPY ./laravel-worker.conf /etc/supervisor/conf.d/

#ENV PATH /scripts:/scripts/aliases:$PATH

#COPY ./scheduler.sh /scripts/scheduler.sh
#RUN chmod 0755 /scripts/scheduler.sh

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod 0755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Expose port 9000 and start php-fpm server (for FastCGI Process Manager)
EXPOSE 9000
CMD ["php-fpm"]
