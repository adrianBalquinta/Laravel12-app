#!/usr/bin/env bash
set -euo pipefail

# 1) Bootstrap project (if repo is empty)
if [ ! -f artisan ]; then
  composer create-project laravel/laravel .
fi

# 2) Env + app key
cp -n .env.example .env
php artisan key:generate --force

# 3) Switch to SQLite (zero config)
mkdir -p database
touch database/database.sqlite
php -r 'file_put_contents(".env", preg_replace("/^DB_CONNECTION=.*/m", "DB_CONNECTION=sqlite", file_get_contents(".env")));'

# 4) Install assets and run migrations
npm install
php artisan migrate --force || true

# 5) Optional niceties
php artisan storage:link || true
