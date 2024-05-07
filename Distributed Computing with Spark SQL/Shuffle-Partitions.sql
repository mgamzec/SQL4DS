-- Databricks notebook source
-- MAGIC %md
-- MAGIC # 2.4 Shuffle Partitions
-- MAGIC
-- MAGIC ## ![Spark Logo Tiny](https://files.training.databricks.com/images/105/logo_spark_tiny.png) In this notebook you:<br>
-- MAGIC * Understand the performance differences between wide and narrow transformations.
-- MAGIC * Optimize Spark jobs by configuring Shuffle Partitions. 

-- COMMAND ----------

-- MAGIC %md-sandbox
-- MAGIC **Narrow Transformations**: The data required to compute the records in a single partition reside in at most one partition of the parent DataFrame.
-- MAGIC
-- MAGIC Examples include:
-- MAGIC * `SELECT (columns)`
-- MAGIC * `DROP (columns)`
-- MAGIC * `WHERE`
-- MAGIC
-- MAGIC <img src="https://files.training.databricks.com/images/eLearning/ucdavis/transformations-narrow.png" alt="Narrow Transformations" style="height:300px"/>
-- MAGIC
-- MAGIC <br/>
-- MAGIC
-- MAGIC **Wide Transformations**: The data required to compute the records in a single partition may reside in many partitions of the parent DataFrame. 
-- MAGIC
-- MAGIC Examples include:
-- MAGIC * `DISTINCT` 
-- MAGIC * `GROUP BY` 
-- MAGIC * `ORDER BY` 
-- MAGIC
-- MAGIC <img src="https://files.training.databricks.com/images/eLearning/ucdavis/transformations-wide.png" alt="Wide Transformations" style="height:300px"/>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Create the table if it doesn't exist.

-- COMMAND ----------

-- MAGIC %run ../Includes/Classroom-Setup

-- COMMAND ----------

-- MAGIC %md
-- MAGIC We're going to disable AQE (adaptive query execution) which is enabled by default. We will cover AQE in a later lesson.

-- COMMAND ----------

SET spark.sql.adaptive.enabled = FALSE

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Let's see the most common call types in our dataset. Any guesses?

-- COMMAND ----------

SELECT `call type`, count(*) AS count
FROM firecalls
GROUP BY `call type`
ORDER BY count DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## What is that 200/200?
-- MAGIC
-- MAGIC Expand out the Spark job above. It should have:
-- MAGIC * 1 stage with 8 tasks
-- MAGIC * 1 stage with 200 tasks
-- MAGIC
-- MAGIC The number assigned to the Job/Stage will depend on how many Spark jobs you have already executed on your cluster.

-- COMMAND ----------

-- MAGIC %md-sandbox
-- MAGIC ## Shuffle Partitions
-- MAGIC
-- MAGIC The `spark.sql.shuffle.partitions` parameter controls how many resulting partitions there are after a shuffle (wide transformation). By default, this value is 200 regardless of how large or small your dataset is, or your cluster configuration.
-- MAGIC
-- MAGIC Let's change this parameter to be 8 (default parallelism in Databricks Community edition).
-- MAGIC
-- MAGIC <img alt="Side Note" title="Side Note" style="vertical-align: text-bottom; position: relative; height:1.75em; top:0.05em; transform:rotate(15deg)" src="https://files.training.databricks.com/static/images/icon-note.webp"/> This configuration will only be changed for this notebook. If you want to set this parameter for all of your clusters, you can also set this configuration at time of cluster creation.
-- MAGIC
-- MAGIC <div><br><img src="https://files.training.databricks.com/images/davis/create_cluster_spark_config.png" style="height: 300px; border: 1px solid #aaa; box-shadow: 5px 5px 5px #aaa; margin: 20px"/></div>

-- COMMAND ----------

SET spark.sql.shuffle.partitions=8

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Let's try this again...

-- COMMAND ----------

SELECT `call type`, count(*) AS count
FROM firecalls
GROUP BY `call type`
ORDER BY count DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Wow! That was a bit faster, and we didn't have to change any of our SQL query code!
