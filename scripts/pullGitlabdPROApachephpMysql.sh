#!/bin/sh
docker-compose --env-file ./env/.pro.env -f ./docker/docker-compose.pull.gitlab.pro.yml up --build -d apachephp mysql