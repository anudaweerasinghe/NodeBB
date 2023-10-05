#!/bin/bash

if [[ -z "${_REDIS_HOST+x}" ]]; then
  # var is not defined
  echo "Error: REDIS_HOST is not defined!"
  exit 1
fi

if [[ -z "${_REDIS_PORT+x}" ]]; then
  # var is not defined
  echo "Error: REDIS_PORT is not defined!"
  exit 1
fi

if [[ -z "${_REDIS_PASSWORD+x}" ]]; then
  # var is not defined
  echo "Error: REDIS_PASSWORD is not defined!"
  exit 1
fi

# Read the JSON file
json_data=$(cat "config_template.json")

# Update the JSON file with the environment variables
json_data=$(jq --arg host "$_REDIS_HOST" --arg port "$_REDIS_PORT" --arg password "$_REDIS_PASSWORD" '.redis.host = $host | .redis.port = $port | .redis.password = $password' <<< "$json_data")

# Write the updated JSON file to config.json
echo "$json_data" > "config.json"