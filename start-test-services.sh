#!/bin/bash

docker compose pull

docker compose build

docker compose up -d

sleep 20

curl -X POST -H "Content-Type: application/json" -d @data.json http://localhost:8081/connectors

# Extract the _id of the first connector from the response
_id=$(curl -s http://localhost:8081/connectors | jq -r '.[0]._id')

curl "http://localhost:8081/connectors/$_id?batteryCapacityKWh=40&socPercentage=20"

docker compose down
