#!/bin/bash

# require file and tileset name for arguments
if [ "$#" -ne 2 ]; then
    echo "Upload needs a path to the tileset and its name, e.g. 'upload data/czechia.mbtiles czechia'"
	exit 1
fi

# require the mapbox username and token to be provided via variables
if [ -z "$MAPBOX_USERNAME" ] || [ -z "$MAPBOX_TOKEN" ]; then
	echo "MAPBOX_USERNAME and MAPBOX_TOKEN muset be set"
	exit 1
fi

# get temporary AWS credentials to stage the dataset as described in https://www.mapbox.com/api-documentation/#retrieve-s3-credentials
CREDS=$(curl -X POST "https://api.mapbox.com/uploads/v1/${MAPBOX_USERNAME}/credentials?access_token=${MAPBOX_TOKEN}")

# export credentials into env variables
export AWS_ACCESS_KEY_ID=$(echo ${CREDS} | jq -r '.accessKeyId')
export AWS_SECRET_ACCESS_KEY=$(echo ${CREDS} | jq -r '.secretAccessKey')
export AWS_SESSION_TOKEN=$(echo ${CREDS} | jq -r '.sessionToken')

BUCKET=$(echo ${CREDS} | jq -r '.bucket')
KEY=$(echo ${CREDS} | jq -r '.key')

# upload file to AWS using retrieved credentials, see https://www.mapbox.com/help/upload-curl/ for details
aws s3 cp $1 s3://${BUCKET}/${KEY} --region us-east-1

# initiate upload to Mapbox
UPLOAD=$(curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -d '{
  "url": "http://'${BUCKET}'.s3.amazonaws.com/'${KEY}'",
  "tileset": "'${MAPBOX_USERNAME}'.'$2'",
  "name": "'$2'"
}' 'https://api.mapbox.com/uploads/v1/'${MAPBOX_USERNAME}'?access_token='${MAPBOX_TOKEN}'')

# extract the upload id to query progress later
UPLOAD_ID=$(echo $UPLOAD | jq -r '.id')

# query upload progress until 'done'
echo "Processing..."

DONE=0
until [ "$DONE" -eq 1 ]; do
	sleep 1
	RESPONSE=$(curl -s "https://api.mapbox.com/uploads/v1/${MAPBOX_USERNAME}/${UPLOAD_ID}?access_token=${MAPBOX_TOKEN}")
	DONE=$(echo ${RESPONSE} | jq '.progress')
done

echo "done"