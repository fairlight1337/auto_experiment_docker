#!/bin/bash

CONTAINERS=`docker ps -a | cut -d' ' -f1`

for container in $CONTAINERS; do
    docker rm $container
done
