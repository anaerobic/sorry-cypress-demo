#!/bin/bash

parallelism=${1:-2}

echo "parallelism: $parallelism"

docker-compose up --force-recreate -d director

docker-compose up --build --scale runner=$parallelism runner

docker-compose kill director
