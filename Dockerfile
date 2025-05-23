FROM php:8.3-fpm
#FROM php:7.4-fpm

RUN apt-get update && apt-get install -y \
    curl \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    nano \
#   libzmq3-dev \
# GD
    libwebp-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libxpm-dev \
    libfreetype6-dev \
    libzip-dev \
    zlib1g-dev

RUN apt-get install -y libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql

#xdebug
#RUN pecl install xdebug xhprof && docker-php-ext-enable xdebug xhprof

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
# GD
RUN docker-php-ext-configure gd --with-webp --with-jpeg --with-xpm --with-freetype

RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd intl pdo_pgsql pgsql sockets zip

#COPY custom.conf /etc/apache2/sites-available/custom.conf

#ADD php-zmq /usr/local/php-zmq

#RUN cd /usr/local/php-zmq \
#    && phpize \
#    && ./configure \
#    && make --silent \
#    && make install \
#    && echo "extension=zmq.so" >> `php --ini | grep "Loaded Configuration" | sed -e #"s|.*:\s*||"` \
#    && cd .. \
#    && rm -r php-zmq

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
