#!/bin/bash

IMG_NAME="amithkoujalgi/spark-with-hadoop-yarn-cluster"

# CLEANUP OLD CONTAINERS
docker rm $(docker stop $(docker ps -a -q --filter ancestor=$IMG_NAME --format="{{.ID}}")) || true
docker container prune -f || true



