#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- php-fpm "$@"
fi

if [ "$1" = 'php-fpm' ]; then
	if [ "$APP_ENV" = 'local' ]; then
        chmod 777 storage
        chmod 777 bootstrap/cache/
        composer install --prefer-dist --no-progress --no-interaction
        php artisan key:generate
	fi
fi

exec docker-php-entrypoint "$@"
