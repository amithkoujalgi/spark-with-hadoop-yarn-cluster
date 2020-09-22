# Docker setup for Hadoop YARN cluster for Spark 2.4.1

This is a Docker setup that allows to deploy multi-node Hadoop cluster with Spark 2.4.1 on YARN

## Build image

```bash
./build.sh
```

## Run  
- Run `./start-cluster.sh`

Once the services are up, you can access the following:

- Hadoop cluster Web UI: http://localhost:8088
- Spark Web UI: http://localhost:8080
- HDFS Web UI: http://localhost:50070
  

## Access Hadoop master container 

```bash
docker exec -it mycluster-master bash
```

### Run Spark applications on cluster
- Spark-shell: 

```bash
spark-shell --master yarn --deploy-mode client
```

## Run a sample PySpark app on the cluster
```
docker exec -it mycluster-master spark-submit \
    --master yarn \
    /examples/pyspark-job.py
```
### Run Java Spark applications on cluster

- Spark Submit: 

Client Mode:

```bash
spark-submit \
    --master yarn \
    --deploy-mode client \
    --num-executors 2 \
    --executor-memory 4G \
    --executor-cores 4 \
    --class org.apache.spark.examples.SparkPi \
    $SPARK_HOME/examples/jars/spark-examples_2.11-2.4.1.jar
```

Cluster Mode:

```bash
spark-submit \
    --master yarn \
    --deploy-mode cluster \
    --num-executors 2 \
    --executor-memory 4G \
    --executor-cores 4 \
    --class org.apache.spark.examples.SparkPi \
    $SPARK_HOME/examples/jars/spark-examples_2.11-2.4.1.jar
```

## Stop 

```bash
./stop-cluster.sh
```