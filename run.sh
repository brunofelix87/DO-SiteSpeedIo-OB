#!/bin/bash

# We use the autobuild to always test our new functionality. But YOU should not do that!
# Instead use the latest tagged version as the next row
# DOCKER_CONTAINER=sitespeedio/sitespeed.io:10.1.0

DOCKER_CONTAINER=sitespeedio/sitespeed.io:14.4.0
DOCKER_SETUP="--cap-add=NET_ADMIN --shm-size=2g --rm -v /config:/config -v "$(pwd)":/sitespeed.io -v /etc/localtime:/etc/localtime:ro -e MAX_OLD_SPACE_SIZE=3072 "
CONFIG="--config ./config"
#BROWSERS=(chrome firefox)
BROWSERS=(chrome)

# We loop through all directories we have
# We run many tests to verify the functionality of sitespeed.io and you can simplify this by
# removing things you don't need!

for url in tests/$TEST/desktop/urls/*.txt ; do
    [ -e "$url" ] || continue
    for browser in "${BROWSERS[@]}" ; do
        POTENTIAL_CONFIG="./config/$(basename ${url%%.*}).json"
        [[ -f "$POTENTIAL_CONFIG" ]] && CONFIG_FILE="$(basename ${url%.*}).json" || CONFIG_FILE="desktop_new.json"
        NAMESPACE="--graphite.namespace BEEHIVE.$(basename ${url%%.*})"
        docker run $DOCKER_SETUP $DOCKER_CONTAINER $NAMESPACE $CONFIG/$CONFIG_FILE -b $browser $url
        #DOCKERVARS="docker run $DOCKER_SETUP $DOCKER_CONTAINER $NAMESPACE $CONFIG/$CONFIG_FILE -b $browser $url"
        #echo $(basename ${url%.*})
        #echo $(basename ${url%%.*})
        #echo $DOCKERVARS
        control
    done
done

# Remove the current container so we fetch the latest autobuild the next time
# If you run a stable version (as YOU should), you don't need to remove the container,
# instead make sure you remove all volumes (of data)
# docker volume prune -f
#docker system prune --all --volumes -f
sleep 20
