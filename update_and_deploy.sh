#!/bin/bash

directories=("devops" "front-end" "gpt-service" "organization-api")

pull_in_directory() {
    echo "Performing git pull in $1..."
    pushd $1 
    git pull
    if [ $? -ne 0 ]; then
        echo "Error occurred in $1"
        popd
        exit 1
    fi
    popd
}

initial_dir=$(pwd)

for dir in "${directories[@]}"; do
    pull_in_directory "../$dir"
done

cd "$initial_dir"
echo "Starting Docker compose in devops..."
docker-compose up -d