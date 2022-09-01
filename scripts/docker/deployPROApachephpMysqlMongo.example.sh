#!/bin/sh
docker-compose --env-file env/.pro.example.env -f ./docker/docker-compose.pull.pro.yml up --build -d