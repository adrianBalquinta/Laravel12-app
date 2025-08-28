# Devcontainers PHP image includes PHP, Composer, and common tools.
FROM mcr.microsoft.com/devcontainers/php:1-8.3-bookworm

# Install libs and compile common PHP extensions.
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libonig-dev libzip-dev libicu-dev libpq-dev libsqlite3-dev \
    libjpeg62-turbo-dev libfreetype6-dev libpng-dev git unzip curl \
 && docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install -j"$(nproc)" gd intl pdo_mysql pdo_pgsql pdo_sqlite bcmath zip \
 && apt-get clean && rm -rf /var/lib/apt/lists/*
