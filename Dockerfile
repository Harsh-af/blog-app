# Use the official PHP image as the base image
FROM php:8.2.12-apache

# Set the working directory inside the container
WORKDIR /var/www/html

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql

# Enable Apache modules
RUN a2enmod rewrite

# Copy your Laravel application code into the container
COPY . .

# Install Composer (a PHP package manager)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install your Laravel project's dependencies
# RUN composer install

# Set permissions (adjust this as needed for security)
RUN chown -R www-data:www-data storage bootstrap/cache

# Expose port 80 for the Apache web server
EXPOSE 80

CMD php artisan serve --host=0.0.0.0 --port=8000
