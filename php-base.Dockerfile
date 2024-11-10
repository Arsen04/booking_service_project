# Inherit from the base PHP image
FROM php:8.1-cli

# Install required extensions and Composer
RUN apt-get update && apt-get install -y \
    curl \
    git \
    libzip-dev \
    unzip \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && docker-php-ext-install mysqli sockets zip

# Set the working directory inside the container
WORKDIR /var/www/html

# Copy the service's source code into the container
COPY . /var/www/html

# Install dependencies using Composer
RUN composer install

# Expose port 80 for HTTP requests
EXPOSE 80

# Start PHP's built-in server
CMD ["php", "-S", "0.0.0.0:80", "public/index.php"]