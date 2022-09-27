#!/bin/bash

UNAME="${1}"
UPASS="${2}"
REPOSITORY="${3}"
DAYS_AGO="${4}"

echo $DAYS_AGO $REPOSITORY $UPASS $UNAME

# get token to be able to talk to Docker Hub
TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${UNAME}'", "password": "'${UPASS}'"}' https://hub.docker.com/v2/users/login/ | jq -r .token)

echo $TOKEN


# get tags for repo
echo "Looping Through ${REPOSITORY} repository in ${UNAME} account"

IMAGE_TAGS=$(curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/${UNAME}/${REPOSITORY}/tags/?page_size=20000 | jq -r '.results|.[]|.name')
# get count for repo
IMAGE_COUNT=$(curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/${UNAME}/${REPOSITORY}/tags/?page_size=20000 | jq -r '.count')

echo "IMAGE COUNT:${IMAGE_COUNT}" 

if (($((IMAGE_COUNT)) <= 100 )); then
  echo "image count less than 100"
else
    COUNT=0
    for IMAGE_TAG in ${IMAGE_TAGS}
    do
    if [[ $i == production* ]]
    then
        echo "Prod images"
    else
            # add last_updated_time
            updated_time=$(curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/${UNAME}/${REPOSITORY}/tags/${IMAGE_TAG}/?page_size=10000 | jq -r '.last_updated')
            echo $updated_time
            datetime=$updated_time
            timeago="${DAYS_AGO} days ago"

            echo $timeago
        

            dtSec=$(date --date "$datetime" +'%s')
            taSec=$(date --date "$timeago" +'%s')

            echo "INFO: dtSec=$dtSec, taSec=$taSec"

                    if [ $dtSec -lt $taSec ]
                    then
                        echo "This image ${UNAME}/${REPOSITORY}:${IMAGE_TAG} is older than ${DAYS_AGO} days, deleting this  image"
                        curl -s  -X DELETE  -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/${UNAME}/${REPOSITORY}/tags/${IMAGE_TAG}/
                        let COUNT=COUNT+1
                    fi
        fi 
    done
 echo "${COUNT} IMAGES DELETED FROM ${REPOSITORY}"
fi
