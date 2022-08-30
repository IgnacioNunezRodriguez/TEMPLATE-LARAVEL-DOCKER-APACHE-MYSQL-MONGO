composer install --optimize-autoloader --no-dev --working-dir=./src
docker-compose --env-file ../env/.pro.env -f ./docker-compose.build.pro.yml up --build -d apachephp mysql