# FROM php:8.3-apache

# WORKDIR /var/www/html
# COPY . /var/www/html

# RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# RUN apt-get update && apt-get upgrade -y && docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable mysqli pdo_mysql

# #set environment variable for mysql
# ENV MYSQL_DB=mysqldb
# ENV MYSQL_USER=user
# ENV MYSQL_PASSWORD=pass
# ENV MYSQL_HOST=db
# ENV MYSQL_PORT=3306

# EXPOSE 80

# Use the official PHP image with Apache
FROM php:8.3-apache

# Set the working directory for Apache
WORKDIR /var/www/html

# Copy the current directory contents into the container at /var/www/html
COPY . /var/www/html

# Ensure the permissions are correct for the Apache user
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Append ServerName to the Apache configuration to suppress syntax warnings
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Install dependencies and PHP extensions
RUN apt-get update && apt-get upgrade -y && \
    docker-php-ext-install mysqli pdo pdo
