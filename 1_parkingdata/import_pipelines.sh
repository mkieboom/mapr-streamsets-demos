#!/bin/bash

# MapR Configuration
MAPR_CLUSTER=demo.mapr.com
MAPR_CLDB_HOSTS=192.168.1.11
MAPR_CONTAINER_USER=mapr
MAPR_CONTAINER_GROUP=mapr
MAPR_CONTAINER_UID=5000
MAPR_CONTAINER_GID=5000
MAPR_MOUNT_PATH=/mapr
#$PWD/sdc-data:/data
#18630:18630

MAPR_VERSION=601
MAPR_MEP_VERSION=500

# MapR PACC Streamsets Container Name and Version
MAPR_PACC_STREAMSETS_CONTAINER="mkieboom/mapr-pacc-streamsets-docker"
MAPR_PACC_STREAMSETS_COINTAINER_VERSION=latest
#MAPR_PACC_STREAMSETS_COINTAINER_VERSION=streamsets352_mapr601_mep500


# StreamSets DataCollector Configuration
SDC_USER=admin
SDC_PASSWORD=admin
SDC_URL=localhost
SDC_PORT=18630

# StreamSets DataCollector Pipelines to Import
SDC_PIPELINES=$PWD/pipelines/

# Check if the container is already running
MAPR_PACC_STREAMSETS_CONTAINER_RUNNING=$(docker ps  | awk '{ print $1,$2 }' | grep "$MAPR_PACC_STREAMSETS_CONTAINERL$MAPR_PACC_STREAMSETS_COINTAINER_VERSION" | awk '{print $1 }')

if ( "$(echo $MAPR_PACC_STREAMSETS_CONTAINER_RUNNING |wc -l)" -ne "" ); then
	echo "Container $MAPR_PACC_STREAMSETS_CONTAINER:$MAPR_PACC_STREAMSETS_COINTAINER_VERSION is running with Container ID: $MAPR_PACC_STREAMSETS_CONTAINER_RUNNING"
else
  echo "Container not running, starting it now..."
  # Launch mapr-pacc-streamsets-docker Container
	docker run -d \
	--cap-add SYS_ADMIN \
	--cap-add SYS_RESOURCE \
	--device /dev/fuse \
	-e MAPR_CLUSTER=$MAPR_CLUSTER \
	-e MAPR_CLDB_HOSTS=$MAPR_CLDB_HOSTS \
	-e MAPR_CONTAINER_USER=$MAPR_CONTAINER_USER \
	-e MAPR_CONTAINER_GROUP=$MAPR_CONTAINER_GROUP \
	-e MAPR_CONTAINER_UID=$MAPR_CONTAINER_UID \
	-e MAPR_CONTAINER_GID=$MAPR_CONTAINER_GID \
	-e MAPR_MOUNT_PATH=$MAPR_MOUNT_PATH \
	-v $PWD/sdc-data:/data \
	-p $SDC_PORT:18630 \
	$MAPR_PACC_STREAMSETS_CONTAINER:$MAPR_PACC_STREAMSETS_COINTAINER_VERSION
fi


# Wait for StreamSets to be running on port $SDC_PORT
# TODO
for (i=0; i<)


# Import Pipelines into Streamsets

# for fullpathfilename in $SDC_PIPELINES/*.json;
# do
#     filename=$(basename "$fullpathfilename")
#     # Pipeline names cannot contain whitespaces, replace them with underscores
#     pipelinename=${filename// /_}

#     echo "Importing StreamSets Pipeline: $filename"

#     curl -XPOST -s -u $SDC_USER:$SDC_PASSWORD \
#       -H 'Content-Type: application/json' \
#       -H 'X-Requested-By: My Import Process' \
#       -d "@$fullpathfilename" \
#       http://$SDC_URL:$SDC_PORT/rest/v1/pipeline/$pipelinename/import?autoGeneratePipelineId=true
# done

