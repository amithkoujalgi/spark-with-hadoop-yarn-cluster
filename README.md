# Docker setup for Hadoop YARN cluster for Spark 2.4.1

## docker-spark-yarn-cluster 

This is a Docker setup that allows to deploy multi-node Hadoop cluster with Spark 2.4.1 on YARN

## Build image
- Clone the repo 
- cd inside ../docker-spark-yarn-cluster 
- Run `docker build -t spark-hadoop-yarn-cluster .`

## Run  
- Run `./startHadoopCluster.sh`
- Access to master `docker exec -it mycluster-master bash`

### Run spark applications on cluster : 
- spark-shell : `spark-shell --master yarn --deploy-mode client`
- spark : `spark-submit --master yarn --deploy-mode client or cluster --num-executors 2 --executor-memory 4G --executor-cores 4 --class org.apache.spark.examples.SparkPi $SPARK_HOME/examples/jars/spark-examples_2.11-2.4.1.jar`

- Access to Hadoop cluster Web UI: http://localhost:8088
- Access to Spark Web UI: http://localhost:8080
- Access to HDFS Web UI: http://localhost:50070
  
## Stop 
- `docker stop $(docker ps -a -q)`
- `docker container prune`