# Apache Ray

## Learning Objectives

- Explain how Ray schedules distributed Python tasks and actors.
- Compare task-based and actor-based distributed execution.
- Implement a small Ray workflow for parallel data or AI jobs.
- Identify when Ray is a better fit than Spark or a message queue.
- Evaluate the trade-offs between flexibility, statefulness, and operational complexity.

## Prerequisites

- Intermediate Python
- Comfort with decorators and asynchronous thinking
- Basic distributed-systems concepts

## Big Picture Overview

Ray is a distributed execution engine for Python-heavy workloads. It is especially useful when the work is not a simple batch aggregation job and instead looks like a graph of small tasks, remote stateful workers, simulations, or AI pipeline steps.

You encounter Ray in model serving, hyperparameter tuning, simulation, robotics, agent orchestration, and distributed Python applications. It fills the gap between classic batch engines and low-level cluster programming.

Ray matters because it lets Python developers scale out without rewriting everything in a different language or manually managing distributed worker lifecycles.

## Core Concepts

### 1. Tasks

Tasks are stateless remote functions.

Why they exist:
- They let you parallelize work easily.

When to use them:
- Independent computations
- Fan-out/fan-in processing

When not to use them:
- When you need persistent state between calls

Common mistake:
- Making a task do too much and turning it into a mini service.

### 2. Actors

Actors are stateful workers that keep internal state across calls.

Why they exist:
- Some workloads need memory, caching, or long-lived resources.

When to use them:
- Model servers
- Simulators
- State machines

When not to use them:
- When the work is purely stateless and better expressed as tasks

Common mistake:
- Treating actors like a database. They are not a substitute for durable storage.

### 3. Object Store and References

Ray stores results in a shared object store and passes references instead of large values when possible.

Why it exists:
- It avoids copying large objects repeatedly.

When to use it:
- Large arrays, data frames, intermediate model outputs

Common mistake:
- Passing giant Python objects directly between processes when a reference would be better.

### 4. Scheduling

Ray schedules tasks and actors across cluster resources.

Why it exists:
- Developers should not manually assign every unit of work to a node.

When to use it:
- Anytime the workload can benefit from cluster-wide parallelism

Common mistake:
- Ignoring resource hints and expecting the cluster to magically fit any workload shape.

## Design Pattern Connections

### Command

Remote Ray tasks behave like commands: a unit of work is packaged, sent, and executed elsewhere.

Problem solved:
- Encapsulates work so it can be scheduled and retried.

Relation to Ray:
- `@ray.remote` wraps a function as a distributed command.

```python
import ray

ray.init()

@ray.remote
def square(x):
    return x * x

results = ray.get([square.remote(i) for i in range(5)])
```

Real-world use:
- Parallel preprocessing, tuning, and inference fan-out

### Proxy

Object references act like proxies to remote results.

Problem solved:
- Lets local code talk to distributed state without fetching everything immediately.

Relation to Ray:
- You can pass references around before resolving them with `ray.get`.

## Code Example

### Scenario

Run many scoring jobs in parallel and keep a shared counter of completed work.

### Code

```python
import ray

ray.init()

@ray.remote
def score_item(item):
    return {"item": item, "score": len(item) * 10}

@ray.remote
class ProgressTracker:
    def __init__(self):
        self.done = 0

    def mark_done(self):
        self.done += 1
        return self.done

tracker = ProgressTracker.remote()

items = ["cloud", "serverless", "kubernetes"]
futures = [score_item.remote(item) for item in items]

for future in futures:
    print(ray.get(future))
    print(ray.get(tracker.mark_done.remote()))
```

### Walkthrough

1. Initialize Ray.
2. Define a remote task for stateless scoring.
3. Define an actor to track progress.
4. Launch many tasks in parallel.
5. Read back results and progress updates.

### What Problem It Solves

This pattern works well for fan-out work where you want parallel processing plus a small amount of shared state.

### Trade-offs

- Very flexible for Python teams
- Great for AI and simulation workloads
- More operationally complex than a single-process script
- Requires careful thinking about state ownership and failure handling

### Production Evolution

In production, the actor might wrap a model server or cache, and the tasks might fan out across batches, experiments, or agent steps.

## Real-World Examples

### 1. Hyperparameter Tuning

- Problem: run many training jobs with different parameters
- Application: Ray launches many remote tasks or actors in parallel
- Risk: careless scheduling can oversubscribe GPUs or memory

### 2. AI Inference Orchestration

- Problem: route requests through preprocessing, model inference, and post-processing
- Application: Ray actors can hold model state between requests
- Risk: stateful workers can become bottlenecks if not scaled correctly

### 3. Simulation and Robotics

- Problem: execute many simulations with different starting conditions
- Application: Ray tasks fan out across many workers
- Risk: results need to be persisted externally if the cluster fails

## Guided Walkthrough

1. Introduce Ray as "distributed Python without the hand-rolled plumbing."
2. Compare tasks to function calls and actors to long-lived services.
3. Build the scoring example first.
4. Ask students what should happen if an actor dies.
5. Address confusion between task parallelism and actor state.
6. Transition to the AI workload examples that motivate Ray in the cloud.

## Discussion Questions

1. When is Ray a better fit than Spark?
2. Why are actors useful for model serving?
3. What is the risk of keeping too much state in an actor?
4. How do task retries affect side effects?
5. What kind of workloads are a bad fit for Ray?

## Common Pitfalls

### Overusing actors

- Problem: too many stateful workers increase complexity.
- Avoid it: use tasks when state is not required.

### Treating actor state as durable

- Problem: actor memory is temporary.
- Avoid it: persist important state in an external store.

### Ignoring resource constraints

- Problem: tasks get queued or fail because the cluster cannot satisfy them.
- Avoid it: declare CPU and GPU needs explicitly.

## Best Practices

- Keep tasks small and testable.
- Reserve actors for real stateful behavior.
- Persist critical outputs outside the cluster.
- Monitor scheduling, queue time, and resource usage.
- Use Ray when Python flexibility matters more than a rigid batch model.

## Summary

Ray is a distributed Python framework for tasks, actors, and stateful parallelism. It shines when your job is more dynamic than batch ETL and more scalable than a single host. Use it for AI, simulation, and orchestration-heavy Python workloads.

## Further Reading

- Ray documentation
- Ray Core and Ray Serve guides
- Ray Tune documentation
