#!/usr/bin/env bash
set -euo pipefail

# Create project if empty
if [ ! -f artisan ]; then
  composer create-project laravel/laravel .
fi

# Env & key
cp -n .env.example .env
php artisan key:generate --force

# Default to SQLite (zero-setup)
mkdir -p database
touch database/database.sqlite
# Ensure DB is sqlite in .env (others are ignored)
perl -0777 -pe 's/^DB_CONNECTION=.*/DB_CONNECTION=sqlite/m' -i .env

# Install JS deps and build dev assets
npm install
# don’t start dev servers here; user will run them interactively
php artisan migrate --force || true
