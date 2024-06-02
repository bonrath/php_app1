# FROM php:8.3-apache

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
FROM php:8.3-apache

# Copy files into the container
COPY . /var/www/html

# Set proper permissions for the web directory
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Set ServerName to avoid warnings
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Install necessary PHP extensions
RUN apt-get update && apt-get upgrade -y \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && docker-php-ext-enable mysqli pdo_mysql

# Ensure that the Apache user (www-data) can read the files
RUN chown -R www-data:www-data /var/www/html

# Apache Directory Configuration
RUN echo '<Directory /var/www/html>\n\
    Options Indexes FollowSymLinks\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>' >> /etc/apache2/apache2.conf

# Set environment variables for MySQL
ENV MYSQL_DB=mysqldb
ENV MYSQL_USER=user
ENV MYSQL_PASSWORD=pass
ENV MYSQL_HOST=db
ENV MYSQL_PORT=3306

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]
