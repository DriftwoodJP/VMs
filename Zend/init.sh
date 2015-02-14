#!/bin/bash

echo "host(/): bundle install --path vendor/bundle"
bundle install --path vendor/bundle

echo "host(/www): composer install"
cd www
composer install
