FROM mcr.microsoft.com/devcontainers/php:1-8.3-bookworm

# Needed libs + PHP extensions (SQLite-focused)
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libicu-dev libjpeg62-turbo-dev libfreetype6-dev libpng-dev \
    libzip-dev libsqlite3-dev sqlite3 git unzip curl \
 && docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install -j"$(nproc)" gd intl bcmath zip pdo_sqlite \
 && apt-get clean && rm -rf /var/lib/apt/lists/*
