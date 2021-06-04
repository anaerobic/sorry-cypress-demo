FROM cypress/base:12
# FROM cypress/included:7.4.0

WORKDIR /e2e

COPY package.json .

RUN npm i

RUN $(npm bin)/cypress verify

RUN pwd

CMD $(npm bin)/cy2 run --parallel --record --key $CYPRESS_RECORD_KEY --ci-build-id $CYPRESS_CI_BUILD_ID