#!/bin/sh
eval "$(docker-machine env default)"
docker build -t psl_cts_nginx  -f baseImages/nginx/dockerfile .
docker build -t psl_cts_wso2esb  -f baseImages/wso2esb/dockerfile .

docker-compose up -d
IP_ADDRESS="$(docker-machine ip default)"
echo "System up, access link page here" ${IP_ADDRESS}
read -p "Press any key tear down system."
docker-compose stop
docker-compose rm -f
docker images | grep '^wso2docker' | awk '{print $1}' | xargs docker rmi -f