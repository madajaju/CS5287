# Apache Spark

## Learning Objectives

- Explain why Spark replaced many MapReduce workloads for interactive batch analytics.
- Describe Spark's execution model, including lazy evaluation and DAG scheduling.
- Use DataFrames and basic transformations to express distributed analytics.
- Identify common performance issues such as shuffles, skew, and excessive collect calls.
- Compare Spark's role in ETL, streaming, and machine learning pipelines.

## Prerequisites

- Basic Python or Scala familiarity
- Understanding of files, data frames, and aggregation
- High-level knowledge of cluster computing

## Big Picture Overview

Spark gives developers a higher-level and usually faster way to work with distributed data than classic MapReduce. Instead of forcing every problem into a rigid two-phase model, Spark builds a directed acyclic graph of operations and optimizes execution before running the job.

You will see Spark in data engineering, analytics, ML feature preparation, streaming, and lakehouse architectures. It is common anywhere teams need one engine that can read files, transform them, aggregate them, and feed the results to downstream systems.

Spark matters because it balances developer productivity and execution efficiency. It makes data pipelines easier to express while still scaling across clusters.

## Core Concepts

### 1. SparkSession

SparkSession is the main entry point into Spark.

Why it exists:
- It gives you one object for SQL, DataFrames, and core Spark APIs.

When to use it:
- In every Spark application

When not to use it:
- Never, unless you are inside lower-level framework internals

Common mistake:
- Creating multiple sessions when one shared session would do.

### 2. DataFrames and Datasets

DataFrames are distributed tables with named columns.

Why they exist:
- They make data processing more readable and optimizable than raw RDD code.

When to use them:
- Most ETL and analytics tasks

When not to use them:
- When you need very custom low-level control over partitions or byte-level processing

Common mistake:
- Reaching for RDDs too early when a DataFrame is sufficient.

### 3. Lazy Evaluation

Spark does not execute each transformation immediately. It builds a plan and runs it only when an action is triggered.

Why it exists:
- It enables optimization and avoids unnecessary work.

When to use it:
- Automatically, as part of normal Spark programming

When not to use it:
- You do not opt out of it, but you should understand when actions trigger execution

Common mistake:
- Expecting a transformation to run before an action is called.

### 4. Transformations and Actions

Transformations create new plans; actions return results or write output.

Why it exists:
- It separates planning from execution.

When to use it:
- Every Spark job

Common mistake:
- Calling `collect()` too early and bringing too much data to the driver.

### 5. Shuffles and Partitioning

Spark moves data between executors when a transformation requires re-grouping.

Why it exists:
- Aggregations and joins need related records together.

When to use it:
- Joins, group-bys, repartitioning, global sorts

Common mistake:
- Ignoring data skew. One hot key can slow the whole job.

## Design Pattern Connections

### Facade

SparkSession acts like a facade over a large distributed execution engine.

Problem solved:
- Hides a complicated system behind one simple entry point.

Relation to Spark:
- Users can start with one object and access SQL, streaming, ML, and file reading APIs.

```python
from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("sales-etl").getOrCreate()
```

Real-world use:
- Data teams use SparkSession as the single front door to a cluster job.

### Builder

The SparkSession builder uses the Builder pattern.

Problem solved:
- Lets the caller configure an object step by step before construction.

Relation to Spark:
- You can set application name, master, config, and extensions before creating the session.

## Code Example

### Scenario

Read CSV sales data, compute total revenue by region, and write the result back out.

### Code

```python
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, sum as sum_

spark = SparkSession.builder.appName("sales-summary").getOrCreate()

sales = (
    spark.read
    .option("header", True)
    .option("inferSchema", True)
    .csv("sales.csv")
)

regional = (
    sales.groupBy("region")
    .agg(sum_(col("amount")).alias("total_revenue"))
    .orderBy(col("total_revenue").desc())
)

regional.show()
regional.write.mode("overwrite").parquet("out/regional-summary")
```

### Walkthrough

1. Create the SparkSession.
2. Read structured data into a DataFrame.
3. Group records by region.
4. Aggregate revenue.
5. Write the result to a durable output format.

### What Problem It Solves

This is a typical batch ETL workflow: turn raw rows into a cleaned summary that other systems can use.

### Trade-offs

- Much easier to write than low-level distributed code
- Optimized by Spark's planner
- Still sensitive to bad partitioning and large shuffles

### Production Evolution

In production, this job would read from object storage, run on a cluster manager, and emit output to a lakehouse or warehouse table. It would also have retries, monitoring, and job versioning.

## Real-World Examples

### 1. E-commerce ETL

- Problem: unify web events, orders, and inventory data
- Application: Spark cleans and joins large files before loading dashboards
- Risk: a bad join key can create duplicate rows or huge shuffles

### 2. Fraud Analytics

- Problem: compute features from transaction history
- Application: Spark prepares rolling summaries for an ML model
- Risk: skewed customers or merchants create hotspots

### 3. Education Platform Reporting

- Problem: summarize course activity by school, class, and week
- Application: Spark aggregates logs into enrollment and engagement reports
- Risk: collecting intermediate data on the driver hurts scale

## Guided Walkthrough

1. Start with the question: why not just use MapReduce?
2. Explain that Spark keeps the distributed model but adds a richer execution graph.
3. Build the sales summary example.
4. Ask students where shuffles happen.
5. Address confusion about lazy evaluation and actions.
6. Move into tuning with partition counts, caching, and broadcast joins.

## Discussion Questions

1. Why is Spark easier to work with than MapReduce for many analytics tasks?
2. When should you cache a DataFrame?
3. How can bad partitioning slow a Spark job?
4. What is the risk of overusing UDFs?
5. Why is `collect()` often a code smell in distributed analytics?

## Common Pitfalls

### Collecting too much data

- Problem: the driver runs out of memory.
- Avoid it: keep processing distributed and only collect small results.

### Forcing unnecessary shuffles

- Problem: network cost dominates runtime.
- Avoid it: choose keys and partitions carefully.

### Using UDFs for everything

- Problem: Spark cannot optimize opaque code well.
- Avoid it: use built-in functions when possible.

## Best Practices

- Use DataFrames by default.
- Measure shuffle volume and skew.
- Prefer built-in functions over custom UDFs.
- Cache only reusable intermediate data.
- Write outputs in partitioned formats when query patterns support it.
- Keep jobs reproducible and versioned.

## Summary

Spark is a distributed data processing engine built for higher-level analytics and ETL. It gives teams a single API for structured data, lazy optimization, and scalable execution. Learn it as the practical successor to MapReduce for many batch workloads.

## Further Reading

- Apache Spark documentation
- Spark SQL, DataFrame, and Dataset guides
- Databricks Spark tuning guides
