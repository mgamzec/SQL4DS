-- Databricks notebook source
-- MAGIC %md
-- MAGIC * Get data into Databricks
-- MAGIC * Query Data

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## ![Spark Logo Tiny](https://files.training.databricks.com/images/105/logo_spark_tiny.png) Getting Data into Databricks
-- MAGIC
-- MAGIC There are a number of ways of getting data into Databricks.  In this lesson, you'll upload a flat CSV file into Databricks before creating a table and querying it.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Download Dataset
-- MAGIC
-- MAGIC Download a subset of the Data SF's Fire Department Calls for Service [here](https://s3-us-west-2.amazonaws.com/davis-dsv1071/data/fire-calls/fire-calls-truncated-comma-no-spaces.csv). This dataset is about 85 MB.
-- MAGIC
-- MAGIC The entire dataset is ~1.7GB, and can be found on [Data SF](https://data.sfgov.org/Public-Safety/Fire-Department-Calls-for-Service/nuek-vuh3/data)

-- COMMAND ----------

-- MAGIC %md-sandbox
-- MAGIC ## Import Dataset
-- MAGIC
-- MAGIC **NOTE**: You will need to have a cluster running to add data.<br><br>
-- MAGIC
-- MAGIC 1. Navigate to the `Data` tab on the left hand panel of your Databricks workspace
-- MAGIC <div><br><img src="https://s3-us-west-2.amazonaws.com/files.training.databricks.com/images/davis/import_1.png" style="border: 1px solid #aaa; height: 300px; border-radius: 10px 10px 10px 10px; box-shadow: 5px 5px 5px #aaa; margin: 20px"/></div>
-- MAGIC 2. Select `Create Table`
-- MAGIC <div><br><img src="https://s3-us-west-2.amazonaws.com/files.training.databricks.com/images/davis/import_2.png" style="border: 1px solid #aaa; height: 300px; border-radius: 10px 10px 10px 10px; box-shadow: 5px 5px 5px #aaa; margin: 20px"/></div>
-- MAGIC 3. Click `Browse` and select the file.  If you haven't already downloaded it, you can find it [here](https://s3-us-west-2.amazonaws.com/davis-dsv1071/data/fire-calls/fire-calls-truncated-comma.csv)
-- MAGIC <div><br><img src="https://s3-us-west-2.amazonaws.com/files.training.databricks.com/images/davis/import_3.png" style="border: 1px solid #aaa; height: 300px; border-radius: 10px 10px 10px 10px; box-shadow: 5px 5px 5px #aaa; margin: 20px"/></div>
-- MAGIC 4. Click `Create Table with UI`
-- MAGIC <div><br><img src="https://s3-us-west-2.amazonaws.com/files.training.databricks.com/images/davis/import_4.png" style="border: 1px solid #aaa; height: 400px; border-radius: 10px 10px 10px 10px; box-shadow: 5px 5px 5px #aaa; margin: 20px"/></div>
-- MAGIC 5. Select the cluster you have running.  If you don't have a running cluster, create one in the `Clusters` tab.
-- MAGIC <div><br><img src="https://s3-us-west-2.amazonaws.com/files.training.databricks.com/images/davis/import_56.png" style="border: 1px solid #aaa; height: 600px; border-radius: 10px 10px 10px 10px; box-shadow: 5px 5px 5px #aaa; margin: 20px"/></div>
-- MAGIC 6. Name the table `firecallsuploaded`
-- MAGIC 7. Select `First row is header`
-- MAGIC 8. Select `Infer schema`
-- MAGIC 9. Select `Create Table`
-- MAGIC <div><img src="https://s3-us-west-2.amazonaws.com/files.training.databricks.com/images/davis/import_710.png" style="border: 1px solid #aaa; height: 450px; border-radius: 10px 10px 10px 10px; box-shadow: 5px 5px 5px #aaa; margin: 20px"/></div>
-- MAGIC 10. Continue on in the rest of this notebook.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## ![Spark Logo Tiny](https://files.training.databricks.com/images/105/logo_spark_tiny.png) Querying Data
-- MAGIC
-- MAGIC Now you can access the file you uploaded.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Take a look at the first few lines of the data.

-- COMMAND ----------

SELECT * FROM firecallsuploaded LIMIT 10

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Look at the number of emergency calls by call type.

-- COMMAND ----------

SELECT `Call_Type`, count(1) as count 
FROM firecallsuploaded 
GROUP BY `Call_Type` 
ORDER BY count DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Now look at calls by neighborhood.

-- COMMAND ----------

SELECT `Neighborhooods_-_Analysis_Boundaries` as neighborhood, count(1) as count 
FROM firecallsuploaded 
GROUP BY `Neighborhooods_-_Analysis_Boundaries` 
ORDER BY count DESC

