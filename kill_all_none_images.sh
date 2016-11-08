#!/bin/bash

while IFS= read -r line; do
    img_name=`echo $line | awk '{print $1}'`
    
    if [ "$img_name" = "<none>" ]; then
	img_id=`echo $line | awk '{print $3}'`
	docker rmi $img_id
    fi
done < <(docker images)
