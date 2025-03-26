#!/bin/bash

php artisan migrate --force 
php artisan db:seed --force

# Passport
php artisan passport:install --force


# Set permissions
chmod 755 /var/www/html/.env
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/public/files/* /var/www/html/.env
# Execute the CMD
exec "$@"
