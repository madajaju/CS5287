# LLM Serving in the Cloud

## Learning Objectives

- Explain the main components of an LLM serving system.
- Compare latency, throughput, and cost trade-offs for inference.
- Describe batching, quantization, and model routing strategies.
- Implement a simple API wrapper around a model backend.
- Evaluate production concerns such as monitoring, fallbacks, and safety.

## Prerequisites

- Basic Python and HTTP API understanding
- Familiarity with cloud deployments
- High-level knowledge of model inference or ML APIs

## Big Picture Overview

Serving large language models is a systems problem as much as it is a machine learning problem. A model is only useful in production if it can respond reliably, fast enough, and within a budget that the business can sustain.

This topic shows up in chat assistants, developer tooling, internal knowledge systems, customer support automation, and document workflows. The hard part is balancing user experience, GPU cost, safety, and observability.

## Core Concepts

### 1. Inference Serving Architecture

An LLM serving stack usually includes an API gateway, request queue, model worker, cache, and monitoring.

Why it exists:
- It decouples request traffic from model execution.

When to use it:
- Any production model that receives real user traffic

When not to use it:
- Tiny experiments that do not need reliability or scaling

Common mistake:
- Exposing the raw model directly without request shaping or safety controls.

### 2. Batching

Batching groups requests to improve GPU efficiency.

Why it exists:
- GPUs perform better with larger units of work.

When to use it:
- High-volume inference traffic

When not to use it:
- Ultra-low-latency interactive use where even small queue delays matter

Common mistake:
- Optimizing for throughput while ignoring response time.

### 3. Quantization and Model Size

Quantization reduces numerical precision to lower memory usage and improve speed.

Why it exists:
- Large models are expensive to run.

When to use it:
- When memory is a bottleneck or cost matters significantly

When not to use it:
- When the quality drop is unacceptable for the task

### 4. Routing and Fallbacks

Requests may need to route to different models, versions, or fallback behaviors.

Why it exists:
- Not all prompts require the same model or same level of quality.

When to use it:
- Multi-model systems
- Safety-sensitive workflows

Common mistake:
- Sending every request to the largest model by default.

### 5. Observability

You need metrics for latency, tokens, queue depth, and failure rate.

Why it exists:
- LLM systems can look healthy while silently becoming too slow or too expensive.

## Design Pattern Connections

### Facade

An API wrapper can act as a facade over the model backend.

Problem solved:
- Hides model infrastructure details behind a simple interface.

```python
from fastapi import FastAPI

app = FastAPI()

@app.post("/generate")
def generate(prompt: str):
    return {"text": f"Model response for: {prompt}"}
```

Real-world use:
- Internal copilot services and chat APIs

### Strategy

Different routing or batching policies are strategies.

Problem solved:
- Lets the system choose different execution behavior based on load or request type.

Relation to LLM serving:
- One strategy may prioritize latency, another may prioritize cost.

## Code Example

### Scenario

Wrap a model backend behind a small HTTP API and add a queue-friendly entry point.

### Code

```python
from fastapi import FastAPI

app = FastAPI()

def run_model(prompt: str) -> str:
    return f"Generated answer for: {prompt}"

@app.post("/chat")
def chat(payload: dict):
    prompt = payload["prompt"]
    text = run_model(prompt)
    return {"response": text}
```

### Walkthrough

1. Expose a simple HTTP endpoint.
2. Extract the prompt from the request.
3. Send it to the model backend.
4. Return the generated response.

### What Problem It Solves

This is the minimum production shape for a model API.

### Trade-offs

- Easy to understand
- Easy to extend with auth, logging, and batching
- Not enough for production without rate limiting, queueing, and monitoring

### Production Evolution

In production, you would add authentication, request validation, batching, tracing, guardrails, and backend selection.

## Real-World Examples

### 1. Customer Support Assistant

- Problem: answer frequent support questions quickly
- Application: LLM API responds to user prompts and may route to a fallback search system
- Risk: hallucinated answers can cause support errors

### 2. Developer Copilot

- Problem: help engineers write and explain code
- Application: service batches requests and uses cached completions where possible
- Risk: latency spikes hurt the editing experience

### 3. Internal Knowledge Assistant

- Problem: summarize policy and documentation for employees
- Application: model service retrieves documents and generates a response
- Risk: stale content and permission leaks are serious concerns

## Guided Walkthrough

1. Introduce the problem: models are expensive and sensitive to load.
2. Use the analogy of a busy call center with multiple agents and a queue.
3. Show the FastAPI example.
4. Ask students which metrics matter most: latency, cost, or quality.
5. Address confusion around batching versus asynchronous requests.
6. Transition to guardrails, routing, and safety.

## Discussion Questions

1. Why is batching important for LLM serving?
2. When should a request be routed to a smaller model?
3. What metrics would you monitor first in production?
4. How do caching and fallback systems change the design?
5. What is the biggest risk of exposing a raw model API?

## Common Pitfalls

### Ignoring latency and cost together

- Problem: a system can be fast but too expensive, or cheap but too slow.
- Avoid it: track both dimensions.

### Skipping validation

- Problem: malformed inputs trigger failures or unpredictable responses.
- Avoid it: validate prompt structure and request shape.

### Over-trusting model output

- Problem: hallucinations leak into downstream workflows.
- Avoid it: add human review or verification where needed.

## Best Practices

- Add request validation and authentication.
- Monitor latency, queue depth, GPU usage, and token counts.
- Use batching only when latency budgets allow it.
- Add fallback paths for model failure or overload.
- Treat model outputs as untrusted until verified.

## Summary

LLM serving is the production discipline of delivering model responses reliably, efficiently, and safely. The topic blends infrastructure, API design, batching, and observability. The central question is not "can the model answer?" but "can the service answer predictably at scale?"

## Further Reading

- FastAPI documentation
- vLLM, TGI, and Triton Inference Server docs
- Cloud provider guidance on GPU-based model serving
