# MapReduce

## Learning Objectives

- Explain the MapReduce programming model and the problem it was designed to solve.
- Compare map, shuffle, sort, and reduce phases in a distributed batch job.
- Implement a small MapReduce-style workflow for log or text processing.
- Identify when MapReduce is a strong fit and when a newer framework is a better choice.
- Evaluate the trade-offs between simplicity, fault tolerance, and latency.

## Prerequisites

- Basic Python syntax
- Familiarity with files, lists, and dictionaries
- A high-level understanding of distributed systems
- Comfort reading command-line examples

## Big Picture Overview

MapReduce exists to process large data sets on many machines without forcing developers to manage every distributed detail themselves. The core idea is simple: split a problem into small independent pieces, run them in parallel, then combine the results.

You encounter this style of processing in log analytics, ETL pipelines, search indexing, telemetry aggregation, and any workflow where the input is too large for one machine but the operation itself can be expressed as a map phase and a reduction phase.

The main value of MapReduce is not speed alone. It is also operational clarity. The framework handles partitioning, retries, and task distribution, which makes large-scale batch work more reliable and easier to reason about than a custom distributed script.

## Core Concepts

### 1. Map

The map phase transforms each input record into zero or more intermediate key-value pairs.

Why it exists:
- It exposes parallelism.
- Each record can be processed independently.
- It lets you reframe a problem around a grouping key.

When to use it:
- Tokenizing text
- Extracting fields from logs
- Turning raw events into keyed metrics

When not to use it:
- When the computation depends heavily on previous records
- When you need low-latency interactive responses
- When the job is naturally graph-shaped instead of two-phase

Common mistake:
- Treating map as "whatever preprocessing I want." The map phase should produce meaningful intermediate keys, not just arbitrary side effects.

Simple example:
- Input: `["cloud computing", "cloud native"]`
- Map output: `[("cloud", 1), ("computing", 1), ("cloud", 1), ("native", 1)]`

### 2. Shuffle and Sort

The shuffle phase groups all intermediate values by key and moves them to the right reducer.

Why it exists:
- It is how distributed systems gather related data.
- It creates the grouping boundary between map and reduce.

When to use it:
- Anytime the output depends on aggregation by key

When not to use it:
- If the data can be processed locally without grouping
- If network transfer dominates the runtime and aggregation is unnecessary

Common mistake:
- Ignoring that shuffle is expensive. In real systems, the shuffle is often the most costly step.

### 3. Reduce

The reduce phase aggregates the grouped values into final results.

Why it exists:
- It turns a distributed collection of partial results into a final answer.

When to use it:
- Summing counts
- Building per-user summaries
- Combining metrics over time windows

When not to use it:
- If the result is a stream that should be emitted immediately
- If the work is better handled by a database or streaming engine

Common mistake:
- Doing too much business logic inside the reducer. Reducers should aggregate, not become a second application layer.

### 4. Fault Tolerance

MapReduce frameworks re-run failed tasks.

Why it exists:
- Distributed jobs fail in real life.
- A single worker should not invalidate the whole batch.

When to use it:
- Any large batch job where workers may fail or nodes may disappear

When not to use it:
- When repeated retries would be more expensive than failing fast

Common mistake:
- Writing mappers with side effects. If a mapper writes directly to an external system and then retries, the job can duplicate work.

## Design Pattern Connections

### Strategy

Map and reduce functions are application-defined strategies. The engine provides the execution model; you provide the logic.

Problem solved:
- Lets the framework stay generic while the job logic changes.

Relation to MapReduce:
- The framework does not care what your mapper does, only that it can run across many inputs.

Example:

```python
def word_count_map(line: str):
    for word in line.lower().split():
        yield word, 1

def sum_reduce(key: str, values):
    return key, sum(values)
```

Real-world use:
- Custom aggregation logic in analytics pipelines

### Template Method

The execution engine follows a fixed sequence: split, map, shuffle, reduce.

Problem solved:
- Preserves a stable workflow while allowing user-defined steps.

Relation to MapReduce:
- The high-level algorithm is fixed, but map and reduce hooks vary.

## Code Example

### Scenario

Count the number of times each word appears in a set of text lines.

### Code

```python
from collections import defaultdict

def map_words(lines):
    for line in lines:
        for word in line.lower().split():
            yield word, 1

def shuffle(mapped_items):
    grouped = defaultdict(list)
    for key, value in mapped_items:
        grouped[key].append(value)
    return grouped

def reduce_counts(grouped_items):
    return {key: sum(values) for key, values in grouped_items.items()}

lines = [
    "Cloud computing scales well",
    "Cloud native systems scale horizontally",
]

mapped = list(map_words(lines))
grouped = shuffle(mapped)
result = reduce_counts(grouped)

print(result)
```

### Walkthrough

1. `map_words` turns each line into `(word, 1)` pairs.
2. `shuffle` groups all identical words together.
3. `reduce_counts` sums the counts per word.

### What Problem It Solves

This is the classic pattern for count-style analytics on large inputs.

### Trade-offs

- Simple to understand
- Easy to parallelize
- Slow if you need many passes over the data
- Poor fit for interactive or iterative workloads

### Production Evolution

In production, the "input lines" would likely come from object storage or HDFS, and the job would run across many workers with checkpointing, monitoring, and retries.

## Real-World Examples

### 1. Search Engine Indexing

Search systems use MapReduce-style batching to scan documents, extract terms, and build inverted indexes.

- Problem: build searchable structures from huge corpora
- Application: map extracts terms, reduce merges postings lists
- Trade-off: batch indexing is slow compared to streaming updates, but easier to scale

### 2. Log Aggregation

Cloud platforms often ingest application logs and summarize them by service, error type, or time bucket.

- Problem: make sense of millions of events
- Application: map parses log lines, reduce counts errors
- Trade-off: excellent for offline analysis, not ideal for live alerting

### 3. Finance and Risk Reporting

Financial firms use batch aggregation to compute exposure, totals, and compliance reports.

- Problem: combine large, distributed transaction data sets
- Application: map extracts account facts, reduce aggregates by region or product
- Trade-off: strong auditability, but long run times for big reports

## Guided Walkthrough

1. Introduce the pain point: one machine cannot comfortably process all the data.
2. Use the analogy of many people sorting mail into labeled bins and then counting the contents of each bin.
3. Build the word-count example first.
4. Ask students what should happen if two machines map the same record.
5. Address confusion around shuffle costs and why the network step matters.
6. Transition to Spark by asking how to keep the batch model but reduce repeated disk I/O.

## Discussion Questions

1. Why is MapReduce still useful even though newer engines exist?
2. Which part of the pipeline is usually the bottleneck, and why?
3. When would a streaming system be a better choice than MapReduce?
4. What bugs can appear if a mapper writes to an external database?
5. How does fault tolerance change the way you design map and reduce functions?

## Common Pitfalls

### Side effects in mappers

Mistake:
- Writing to a database or sending emails inside the map phase.

Why it causes problems:
- Retries can duplicate the side effect.

How to avoid it:
- Keep map functions pure whenever possible.

### Ignoring shuffle cost

Mistake:
- Assuming parallelism automatically makes the job fast.

Why it causes problems:
- Large intermediate data sets can saturate the network.

How to avoid it:
- Reduce key cardinality, pre-aggregate when possible, and measure shuffle volume.

### Using MapReduce for interactive queries

Mistake:
- Trying to answer low-latency requests with a batch engine.

Why it causes problems:
- Startup and shuffle overhead are too high.

How to avoid it:
- Use a database, cache, or streaming engine for online traffic.

## Best Practices

- Keep map and reduce functions focused and testable.
- Minimize intermediate data size.
- Use combiners when the framework supports them.
- Measure shuffle cost before optimizing anything else.
- Preserve input and output data lineage for debugging.
- Treat retries as normal, not exceptional.

## Summary

MapReduce is a batch-processing model for turning large distributed data sets into grouped results. It matters because it gives developers a simple way to express parallel data processing while the framework handles distribution and fault tolerance. Use it for offline aggregation and indexing, not for low-latency request paths.

## Further Reading

- Google, "MapReduce: Simplified Data Processing on Large Clusters"
- Hadoop MapReduce documentation
- Spark documentation for the modern evolution of batch processing
