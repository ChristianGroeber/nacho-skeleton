#!/bin/bash

echo "Project Name"
read projectName

cp -r ./nacho-skeleton/root $projectName

cd $projectName

echo "Port"
read port

printf "version: \"3\"\n\nservices:\n   nacho:\n        build:\n            context: .\n            dockerfile: Dockerfile\n        container_name: $projectName\n        ports:\n        - $port:80\n        volumes:\n        - ./:/var/www/html" > docker-compose.yaml

docker-compose up -d
docker exec -it ${projectName} bash <<<EOF
composer install
exit
EOF
