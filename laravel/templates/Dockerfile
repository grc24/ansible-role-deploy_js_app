# Use PHP with Apache as the base image
FROM php:8.2-apache

# Install Additional System Dependencies
RUN apt-get update \
    && apt-get install -y libzip-dev libpq-dev git libpng-dev \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*
# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Enable Apache mod_rewrite for URL rewriting
RUN a2enmod rewrite

# Install PHP extensions
# RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
#     && docker-php-ext-install gd zip bcmath  pdo pdo_pgsql pgsql
RUN docker-php-ext-install gd pdo_mysql zip bcmath 
RUN echo "memory_limit=8192M" >> /usr/local/etc/php/php.ini-production
RUN sed -i 's,^post_max_size =.*$,post_max_size = 8192M,' /usr/local/etc/php/php.ini-production
RUN sed -i 's,^max_execution_time =.*$,max_execution_time = 480,' /usr/local/etc/php/php.ini-production
RUN sed -i 's,^request_terminate_timeout =.*$,request_terminate_timeout = 480,' /usr/local/etc/php/php.ini-production
RUN sed -i 's,^default_socket_timeout =.*$,default_socket_timeout = 3600,' /usr/local/etc/php/php.ini-production
RUN sed -i 's,^upload_max_filesize =.*$,upload_max_filesize = 2048M,' /usr/local/etc/php/php.ini-production
RUN echo "date.timezone=Africa/Porto-Novo" >> /usr/local/etc/php/php.ini-production
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
# Configure Apache DocumentRoot to point to Laravel's public directory
# and update Apache configuration files
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Copy the application code
COPY . /var/www/html
COPY env .env
# Set the working directory
WORKDIR /var/www/html


# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


# Install project dependencies
RUN rm /var/www/html/composer.lock 
RUN composer install 

# Copy the entrypoint script
COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh


# Run the entrypoint script
ENTRYPOINT ["entrypoint.sh"]

# Start Apache in the foreground
CMD ["apache2-foreground"]

