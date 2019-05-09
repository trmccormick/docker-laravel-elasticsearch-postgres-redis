docker-laravel-elasticsearch-postgres-redis

This repo for for creating a new Laravel project. 

Simple docker-compose for Laravel, with postgresql, reddis, nginx and php-fpm
Pre-requisites

    Docker running on the host machine.
    Docker compose running on the host machine.
    Basic knowledge of Docker.

Installation

    To get started, the following steps needs to be taken:
    Clone the repo.
    cd laravel-docker-postgres to the project directory.
    cd to web and run the command to create a new Laravel project into application directory.
    cd .. to back the project directory.
    cp .env.example .env to use env config file
    Run docker-compose up -d to start the containers.
    Visit http://localhost to see your Laravel application.
    Try to connect 127.0.0.1:5432 to access Postgres
    After starting, note that one directory and one file will be created with name postgres and file data, this files are Database archives

usage:
    ./setup.sh to begin the setup by answering a few simple questions the script will configure
    your new application for you to start development.
 
Images

    redis:alpine
    postgres:9.5-alpine
    nginx:alpine
    php71-fpm:latest
    elasticsearch:6.6.2

SourceFiles
In the serverConfiguration directory the deploy folder this contains 2 docker files dev.app.docker for the laravel application and dev.web.docker for nginx also a dev.vhost.conf for nginx configuration.