#!/bin/bash
# Ask the user for the name of the new project

echo What would you like to call your new Laravel Project?

read projectname

# make missing folders
mkdir -p src/$projectname
mkdir -p serverConfiguration/env

[ -f ./serverConfiguration/env/.env.docker ] && rm ./serverConfiguration/env/.env.docker

tee ./serverConfiguration/env/.env.docker <<< "PROJECT_NAME=$projectname"

echo Create Default Database username?

read dbusername

echo Set Password

read dbpassword

[ -f ./serverConfiguration/env/.env.postgres ] && rm ./serverConfiguration/env/.env.postgres

tee ./serverConfiguration/env/.env.postgres <<< "POSTGRES_USER=$dbusername"
echo "POSTGRES_PASSWORD=$dbpassword"  | tee -a ./serverConfiguration/env/.env.postgres 
echo "POSTGRES_DB=$projectname"  | tee -a ./serverConfiguration/env/.env.postgres 

cp ./serverConfiguration/env/.env.docker .env

docker-compose up -d

containername=$projectname"-app"

until [ "`/usr/bin/docker inspect -f {{.State.Health.Status}} $containername`"=="healthy" ]; do
    sleep 0.1;
done;

# update composer and create new laravel project
docker exec -t $containername composer create-project --prefer-dist laravel/laravel $projectname

# install elasticsearch with composer and then update
docker exec -t $containername sh -c "cd $projectname && composer require elasticsearch/elasticsearch:6.7 && composer update"

# adjust .env so it works with postgres
docker exec -t $containername sh -c "cd $projectname && php artisan key:generate"
docker exec -t $containername sh -c "cd $projectname && sed -i -e 's/mysql/pgsql/g' -e 's/DB_HOST=127.0.0.1/DB_HOST=database/g' .env"
docker exec -t $containername sh -c "cd $projectname && sed -i -e 's/3306/5432/g' -e 's/DB_DATABASE=homestead/DB_DATABASE=$projectname/g' .env"
docker exec -t $containername sh -c "cd $projectname && sed -i -e 's/homestead/$dbusername/g' -e 's/secret/$dbpassword/g' .env"
docker exec -t $containername sh -c "cd $projectname && sed -i -e 's/REDIS_HOST=127.0.0.1/REDIS_HOST=redis/g' .env"

# restart container so it connects to correct database
docker restart $containername

# generate key, run migrations and seed database
docker exec -t $containername sh -c "cd $projectname && php artisan key:generate && php artisan migrate --seed"
