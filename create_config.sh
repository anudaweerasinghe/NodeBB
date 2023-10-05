#!/bin/bash

# Read the JSON file
json_data=$(cat "config_template.json")

# Update the JSON file with the environment variables
json_data=$(jq --arg host "$REDIS_HOST" --arg port "$REDIS_PORT" --arg password "$REDIS_PASSWORD" '.redis.host = $host | .redis.port = $port | .redis.password = $password' <<< "$json_data")

# Write the updated JSON file to config.json
echo "$json_data" > "config.json"

cat config.json
