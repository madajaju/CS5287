# GPU Architectures for Cloud

## Learning Objectives

- Explain why GPUs are valuable for cloud workloads.
- Compare CPU and GPU execution models.
- Describe GPU memory hierarchy, batching, and throughput trade-offs.
- Identify cloud virtualization and sharing approaches for GPUs.
- Evaluate when a GPU workload is worth the cost and complexity.

## Prerequisites

- Basic computer architecture concepts
- Familiarity with Python and ML workflows
- High-level understanding of cloud instances and scheduling

## Big Picture Overview

GPUs are specialized processors designed for massive parallel work. In the cloud, they are central to machine learning, computer vision, simulation, rendering, and scientific computing. The challenge is not just "how fast is the GPU" but how to use it efficiently in a shared cloud environment.

This topic matters because GPU instances are expensive, limited, and often shared. Teams must think about memory, batch size, virtualization, and utilization if they want good performance and reasonable cost.

## Core Concepts

### 1. CPU vs. GPU

CPUs are general-purpose. GPUs are throughput-oriented.

Why it exists:
- CPUs are optimized for flexibility and control.
- GPUs are optimized for parallel arithmetic.

When to use a GPU:
- Matrix-heavy ML inference or training
- Image and video processing
- Large parallel simulation workloads

When not to use a GPU:
- Small request/response workloads
- Branch-heavy logic with little parallelism

Common mistake:
- Assuming a GPU always makes a workload faster.

### 2. Memory Hierarchy

GPU performance depends heavily on how data moves through memory.

Why it exists:
- GPU cores are fast, but memory transfers can dominate runtime.

When to use it:
- Any workload where data reuse and batching matter

Common mistake:
- Moving data back and forth between CPU and GPU too often.

### 3. Batching

Batching combines many small requests into larger GPU-friendly work units.

Why it exists:
- GPUs are efficient when there is enough parallel work.

When to use it:
- Inference serving
- Image preprocessing
- Vector operations

When not to use it:
- Single low-latency interactive operations where batching delay is unacceptable

### 4. Virtualization and Sharing

Cloud providers use techniques such as GPU passthrough, time slicing, and Multi-Instance GPU (MIG) partitioning to share GPUs.

Why it exists:
- GPUs are scarce and costly.

When to use it:
- Multi-tenant cloud workloads

Common mistake:
- Ignoring contention between tenants or workloads.

## Design Pattern Connections

No classic GoF pattern dominates GPU architecture. The main design concern is abstraction over hardware capabilities, often through driver layers and runtime APIs. In cloud engineering, the closest practical pattern is a facade over low-level device management.

## Code Example

### Scenario

Compare CPU and GPU-style vector multiplication at a high level.

### Code

```python
import numpy as np

a = np.random.rand(1000, 1000)
b = np.random.rand(1000, 1000)

# CPU-style compute using NumPy
c = a @ b
print(c.shape)
```

### Walkthrough

1. Build two matrices.
2. Multiply them with vectorized math.
3. Observe that large matrix operations are a natural fit for GPU acceleration.

### What Problem It Solves

This kind of work is common in training and inference workloads.

### Trade-offs

- Vectorized math is easy to express
- GPU acceleration can be dramatic
- Data transfer overhead can erase gains if the workload is too small

### Production Evolution

In production, the code would likely run inside a framework such as PyTorch, TensorFlow, CuPy, or JAX, with explicit GPU placement and batching.

## Real-World Examples

### 1. LLM Inference

- Problem: answer many model requests quickly
- Application: GPUs accelerate token generation and matrix math
- Risk: bad batching leads to underutilized hardware

### 2. Computer Vision Services

- Problem: classify or detect objects in images
- Application: GPUs process many images in parallel
- Risk: memory pressure can limit batch size

### 3. Scientific Simulation

- Problem: run repeated numeric simulations
- Application: GPUs parallelize the math-heavy core
- Risk: transfer bottlenecks and kernel inefficiencies

## Guided Walkthrough

1. Introduce GPUs as throughput engines, not general-purpose replacements.
2. Compare a single-request CPU mindset with batched GPU thinking.
3. Show the matrix example.
4. Ask students when batching hurts latency.
5. Address confusion about why expensive hardware can still be underused.
6. Transition to model serving, where batching and throughput become operational concerns.

## Discussion Questions

1. Why can a GPU be slower than a CPU for small workloads?
2. What is the biggest hidden cost when using GPUs in the cloud?
3. Why does batching improve GPU efficiency?
4. When is GPU virtualization helpful, and when is it risky?
5. How would you decide if a workload justifies GPU spend?

## Common Pitfalls

### Treating all workloads as GPU-friendly

- Problem: costs go up without performance gains.
- Avoid it: benchmark first.

### Ignoring data transfer overhead

- Problem: PCIe or network copies dominate runtime.
- Avoid it: keep data close to the device and minimize transfers.

### Choosing the wrong batch size

- Problem: too small wastes the GPU, too large hurts latency.
- Avoid it: profile throughput and latency together.

## Best Practices

- Measure before optimizing.
- Batch requests when latency targets allow it.
- Keep data movement low.
- Monitor memory utilization and queue depth.
- Choose instance types based on the actual workload pattern.

## Summary

GPU architectures matter because cloud AI and simulation workloads depend on parallel compute, memory efficiency, and batching. Learn to think about GPU use as an economic and architectural decision, not just a hardware upgrade.

## Further Reading

- NVIDIA CUDA documentation
- PyTorch GPU documentation
- Cloud provider GPU instance docs
