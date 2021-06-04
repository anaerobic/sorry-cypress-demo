#!/bin/bash

parallelism=${1:-2}

echo "parallelism: $parallelism"

docker kill cypress-director

docker run --rm --name=cypress-director -d -p 1234:1234 agoldis/sorry-cypress-director

cy2_run() {
  CYPRESS_API_URL="http://localhost:1234/" ./node_modules/.bin/cy2 run --parallel --record --key somekey --ci-build-id hello-cypress
}

trap 'pkill -P $$' SIGINT SIGTERM

for i in $(seq 1 $parallelism); do
  echo "starting runner #$i"
  cy2_run &
done

wait
