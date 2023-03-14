#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- php-fpm "$@"
fi

if [ ! -f composer.json ]; then
    rm -Rf tmp/

    git config --global user.email "you@example.com"
    git config --global user.name "Your Name"
    
    symfony new --webapp tmp
    
    cd tmp
    rm -rf docker-compose*
    symfony composer require "php:>=$PHP_VERSION"
    symfony composer config --json extra.symfony.docker 'true'
    cp -Rp . ..
    cd -

    rm -Rf tmp/
fi

if [ ! -d vendor ]; then
    symfony composer install
fi

chmod -R 777 ./

exec docker-php-entrypoint "$@"