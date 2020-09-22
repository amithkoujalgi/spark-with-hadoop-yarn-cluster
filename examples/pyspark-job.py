from pyspark.sql import SparkSession
from pyspark.sql.types import IntegerType

spark = (
    SparkSession
    .builder
    .appName("Python Spark Sample")
    .getOrCreate()
)

df = spark.createDataFrame([1, 2, 3, 4], IntegerType())
df.show()