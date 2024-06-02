# Use the official PHP image as the base image
FROM php:8.3-apache

# Copy the current directory contents into the container at /var/www/html
COPY . /var/www/html

# Set the ServerName to avoid Apache warning messages
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Update package list, upgrade packages, and install necessary PHP extensions
RUN apt-get update && \
    apt-get upgrade -y && \
    docker-php-ext-install mysqli pdo pdo_mysql && \
    docker-php-ext-enable mysqli pdo_mysql

# Set environment variables for MySQL
ENV MYSQL_DB=mysqldb
ENV MYSQL_USER=user
ENV MYSQL_PASSWORD=pass
ENV MYSQL_HOST=db
ENV MYSQL_PORT=3306

# Expose port 80
EXPOSE 80
