

#!/usr/bin/env bash
set -euo pipefail

# 1) Create a fresh Laravel app ONLY if it's missing
if [ ! -f artisan ]; then
  composer create-project laravel/laravel /tmp/app
  if command -v rsync >/dev/null 2>&1; then
    rsync -a /tmp/app/ . --exclude='.git'
  else
    # fallback if rsync isn't available
    shopt -s dotglob nullglob
    cp -a /tmp/app/* /tmp/app/.[!.]* . 2>/dev/null || true
  fi
  rm -rf /tmp/app
fi

# 2) Ensure .env exists (use your current one if present)
if [ ! -f .env ]; then
  if [ -f .env.example ]; then
    cp .env.example .env
  else
    printf "APP_ENV=local\nAPP_DEBUG=true\nDB_CONNECTION=sqlite\n" > .env
  fi
fi

# 3) App key + SQLite
php artisan key:generate --force
mkdir -p database && touch database/database.sqlite

# set DB_CONNECTION=sqlite (create it if missing)
if grep -q '^DB_CONNECTION=' .env; then
  sed -i 's/^DB_CONNECTION=.*/DB_CONNECTION=sqlite/' .env
else
  echo 'DB_CONNECTION=sqlite' >> .env
fi

# 4) Run migrations (ignore if none yet)
php artisan migrate --force || true
