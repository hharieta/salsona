#!/bin/bash
# Author: Gatovsky
# script for Linux and MacOs


### COLORS
green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
grey="\e[0;37m\033[1m"

DOCKER_BIN=$(which docker)
IMAGE_TAG="salsona-image"
CONTAINER_NAME="salsona-container"
DOCKER_FILE="alpine.dockerfile"
ABS_PATH=$(pwd)

function test_sock {
    if [[ -S /var/run/docker.sock ]]; then
        DOCKER_SOCK=/var/run/docker.sock
    elif [[ -S /run/user/$(id -u)/docker.sock ]]; then
        DOCKER_SOCK=/run/user/$(id -u)/docker.sock
    else
        # TODO: start docker service
        echo -e "\n${yellow}Service dead or not exists${end}"
        DOCKER_SOCK=""
    fi
}

############## MAIN ##############

test_sock

set -euo pipefail
if [[ -f $DOCKER_FILE ]] && [[ $DOCKER_SOCK ]]; then
    docker build --no-cache -t $IMAGE_TAG -f $DOCKER_FILE .
    docker run -d -it --name $CONTAINER_NAME -v $ABS_PATH:/home/node/salsona:rw \
    $IMAGE_TAG /bin/bash
    docker exec -it $CONTAINER_NAME /bin/bash;
else
    if ! [[ -f $DOCKER_FILE ]]; then
        echo -e "\n${red}Dockerfile was not found${end}";
    else
        echo -e "\n${red}Socket was not found${end}";
    fi
fi
