#!/bin/bash

# VARIABLES
IMG_NAME="amithkoujalgi/spark-with-hadoop-yarn-cluster"
HOST_PREFIX="mycluster"
NETWORK_NAME=$HOST_PREFIX

# CLEANUP OLD CONTAINERS
# docker rm $(docker stop $(docker ps -a -q --filter ancestor=$IMG_NAME --format="{{.ID}}")) || true
docker rm $(docker stop $(docker ps -a -q)) || true
docker container prune -f || true

N=${1:-2}
NET_QUERY=$(docker network ls | grep -i $NETWORK_NAME)
if [ -z "$NET_QUERY" ]; then
	docker network create --driver=bridge $NETWORK_NAME
fi

# START HADOOP SLAVES 

i=1
while [ $i -le $N ]
do
	HADOOP_SLAVE="$HOST_PREFIX"-slave-$i

	docker run \
		-v ~/:/app \
		--add-host quickstart.cloudera:192.168.48.217 \
		--name $HADOOP_SLAVE \
		-h $HADOOP_SLAVE \
		--net=$NETWORK_NAME \
		-itd "$IMG_NAME"
		
	i=$(( $i + 1 ))
done

# START HADOOP MASTER

HADOOP_MASTER="$HOST_PREFIX"-master

docker run -v ~/:/app \
		--add-host quickstart.cloudera:192.168.48.217 \
		--name $HADOOP_MASTER \
		-h $HADOOP_MASTER \
		--net=$NETWORK_NAME \
		-p 8088:8088 \
		-p 50070:50070 \
		-p 50090:50090 \
		-p 8080:8080 \
		-itd "$IMG_NAME"


# START MULTI-NODES CLUSTER
docker exec -it $HADOOP_MASTER "/usr/local/hadoop/spark-services.sh"