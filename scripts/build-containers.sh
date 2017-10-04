#!/bin/bash
set -x

ROOT_DIR=`pwd`

# Log into the Bluemix Container Registry
bx cr login

# Build the NGINX image (configure Fast CGI)
cd docker/nginx
docker build --tag registry.ng.bluemix.net/krook/nginx:latest --no-cache .
docker push registry.ng.bluemix.net/krook/nginx:latest

# Move back to ROOT_DIR
cd $ROOT_DIR

# Build the PHP-FPM image (base image, inject code, run composer)
cd docker/php-fpm
docker build --tag registry.ng.bluemix.net/krook/php-fpm:latest --no-cache .
docker push registry.ng.bluemix.net/krook/php-fpm:latest

# Move back to ROOT_DIR
cd $ROOT_DIR

# Build the PHP-FPM image (base image, inject code, run composer)
cd docker/php-cli
docker build --tag registry.ng.bluemix.net/krook/php-cli:latest .
docker push registry.ng.bluemix.net/krook/php-cli:latest

# Move back to ROOT_DIR
cd $ROOT_DIR
