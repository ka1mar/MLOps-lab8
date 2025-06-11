package com.foodfacts.datamart

import org.apache.spark.sql.{SparkSession, DataFrame, SaveMode}
import org.apache.spark.sql.functions.{col, isnan, avg, coalesce}
import org.apache.spark.sql.types.NumericType

class DataMart(
    spark: SparkSession,
    maxMissing: Double,
    minUnique: Double
) {
  private val jdbcUrl = sys.env.getOrElse("MYSQL_URL", "jdbc:mysql://mysql:3306/foodfacts")
  private val jdbcUser = sys.env.getOrElse("MYSQL_USER", "user")
  private val jdbcPassword = sys.env.getOrElse("MYSQL_PASSWORD", "password")

  def readProcessedData(table: String): DataFrame = {
    val rawDF = spark.read
      .format("jdbc")
      .option("driver", "com.mysql.cj.jdbc.Driver")
      .option("url", jdbcUrl)
      .option("dbtable", table)
      .option("user", jdbcUser)
      .option("password", jdbcPassword)
      .load()
    
    preprocessData(rawDF)
  }

  def writeResults(df: DataFrame, table: String): Unit = {
    val cleanedDF = postprocessData(df)
    
    cleanedDF.write
      .format("jdbc")
      .option("driver", "com.mysql.cj.jdbc.Driver")
      .option("url", jdbcUrl)
      .option("dbtable", table)
      .option("user", jdbcUser)
      .option("password", jdbcPassword)
      .mode(SaveMode.Append)
      .save()
  }

  private def preprocessData(df: DataFrame): DataFrame = {
    val numericCols = df.schema.fields
      .filter(_.dataType.isInstanceOf[NumericType])
      .map(_.name)
    
    val filteredCols = numericCols.filter { colName =>
      val total = df.count().toDouble
      val missing = df.filter(col(colName).isNull || isnan(col(colName))).count()
      val unique = df.select(colName).distinct().count()
      
      (missing / total < maxMissing) && (unique / total >= minUnique)
    }
    
    val imputedDF = filteredCols.foldLeft(df) { (currentDF, colName) =>
      currentDF.withColumn(colName, 
        coalesce(col(colName), avg(colName).over()))
    }
    
    imputedDF.select(filteredCols.map(col): _*)
  }

  private def postprocessData(df: DataFrame): DataFrame = {
    df.withColumn("prediction", col("prediction").cast("float"))
  }
}
