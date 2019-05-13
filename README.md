# docker-laravel-elasticsearch-postgres-redis

This repo for for creating a new Laravel project. 

Simple docker-compose for Laravel, with postgresql, reddis, nginx and php-fpm

# Pre-requisites

    Docker running on the host machine.
    Docker compose running on the host machine.
    Basic knowledge of Docker.

# usage:
    ./setup.sh to begin the setup by answering a few simple questions the script will configure
    your new application for you to start development.
    
    Once this has completed open a web browser and go to http://localhost/ you should see the default Laravel page.
    
    Delete the ./setup.sh this will not be used after you create your project.
 
# Images

    redis:alpine
    postgres:9.5-alpine
    nginx:alpine
    php71-fpm:latest
    elasticsearch:6.6.2

# SourceFiles
In the serverConfiguration directory the deploy folder this contains 2 docker files dev.app.docker for the laravel application and dev.web.docker for nginx also a dev.vhost.conf for nginx configuration.

# Configuring Elasticsearch
For reference I tried using the following repo to setup elasticsearch in a demo project.

    https://github.com/madewithlove/laravel-elasticsearch-demo
