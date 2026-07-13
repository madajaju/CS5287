# Agentic Workflows

## Learning Objectives

- Explain what makes a workflow agentic rather than a simple prompt-response interaction.
- Describe planning, tool use, memory, and orchestration in agent systems.
- Implement a small multi-step workflow that calls tools and records results.
- Evaluate failure modes such as hallucination, loopiness, and poor tool selection.
- Design guardrails that preserve human control and engineering accountability.

## Prerequisites

- Basic Python
- Familiarity with APIs and JSON
- Understanding of LLM serving concepts

## Big Picture Overview

Agentic workflows chain together multiple AI steps to solve a task. Instead of asking one prompt and accepting one answer, the system may plan, search, call tools, retrieve data, reflect on output, and continue until it reaches a useful result.

This topic appears in copilots, research assistants, automation pipelines, and operations tooling. The benefit is flexibility. The risk is complexity. Once the AI can act, the system needs stronger guardrails, logging, and human review.

## Core Concepts

### 1. Task Decomposition

The agent breaks a problem into smaller steps.

Why it exists:
- Large tasks are easier to solve when planned incrementally.

When to use it:
- Multi-step research
- Code generation with validation
- Knowledge work workflows

When not to use it:
- Simple requests that do not need orchestration

### 2. Tool Use

Agents can call APIs, search systems, or internal tools.

Why it exists:
- Models are stronger when they can access live data and actions.

When to use it:
- Retrieval
- Calculations
- External system actions

When not to use it:
- If the tool introduces more risk than value

Common mistake:
- Letting the model choose arbitrary tools without constraints.

### 3. Memory and State

Agents often need working memory or persisted context.

Why it exists:
- Multi-step work needs continuity across steps.

When to use it:
- Long tasks
- Multi-turn workflows

Common mistake:
- Storing too much unverified conversation history and confusing the agent.

### 4. Orchestration

An orchestrator controls the order of steps, retries, and stopping conditions.

Why it exists:
- The system should not depend on a single free-form model response.

When to use it:
- Production agent pipelines

Common mistake:
- Allowing the model to control its own loop indefinitely.

### 5. Guardrails

Guardrails limit unsafe actions and require validation.

Why it exists:
- Agentic systems can make mistakes quickly and repeatedly.

When to use it:
- Any production agent

Common mistake:
- Assuming prompt wording alone is enough protection.

## Design Pattern Connections

### Command

Tool calls can be modeled as commands.

Problem solved:
- Encapsulates an action so it can be queued, audited, or retried.

Relation to agentic workflows:
- Each tool invocation is a discrete command with inputs and outputs.

```python
def search_docs(query):
    return f"results for {query}"
```

### Builder

Prompt assembly and workflow construction often behave like a builder.

Problem solved:
- Builds a complex request in steps.

Relation to agentic workflows:
- The orchestrator may accumulate context before executing a step.

## Code Example

### Scenario

Create a simple research agent that plans, searches, and summarizes.

### Code

```python
def plan(task):
    return ["search", "summarize"]

def search(query):
    return f"Found sources for {query}"

def summarize(evidence):
    return f"Summary based on: {evidence}"

task = "Explain Spark shuffles"
steps = plan(task)
evidence = []

for step in steps:
    if step == "search":
        evidence.append(search(task))
    elif step == "summarize":
        print(summarize(evidence))
```

### Walkthrough

1. Plan the work into steps.
2. Search for evidence.
3. Summarize the collected information.

### What Problem It Solves

The agent does not answer blindly. It first gathers evidence and then produces a response.

### Trade-offs

- More capable than a single prompt
- Easier to inspect than an opaque monolithic generation step
- More failure-prone if tool use is not constrained

### Production Evolution

In production, each step would be logged, validated, and possibly reviewed by a human before any external action occurs.

## Real-World Examples

### 1. Technical Research Assistant

- Problem: gather references and write an internal briefing
- Application: the agent searches docs, extracts notes, and drafts a summary
- Risk: bad citations or hallucinated claims

### 2. Operations Assistant

- Problem: investigate alerts and suggest next steps
- Application: the agent reads logs, checks dashboards, and drafts a runbook action
- Risk: unsafe automated remediation

### 3. Coding Assistant

- Problem: help a developer debug and explain code
- Application: the agent inspects files, runs tests, and proposes changes
- Risk: incorrect fixes that look plausible

## Guided Walkthrough

1. Introduce the difference between "answering" and "acting."
2. Use the analogy of a project assistant who can research, write, and check work.
3. Build the simple plan-search-summarize workflow.
4. Ask students where the workflow could fail.
5. Address confusion about memory versus conversation history.
6. Transition to guardrails and human review.

## Discussion Questions

1. What makes a workflow agentic rather than just prompt chaining?
2. Where should human approval be required?
3. How do you decide which tools to expose?
4. What kinds of mistakes become more dangerous in agentic systems?
5. How would you log and audit tool use?

## Common Pitfalls

### Unlimited loops

- Problem: the agent keeps trying forever.
- Avoid it: set stopping criteria and retry limits.

### Unsafe tool access

- Problem: the model can take actions it should not take.
- Avoid it: expose only approved tools and permissions.

### No validation of outputs

- Problem: the system trusts hallucinated results.
- Avoid it: verify against sources, tests, or human review.

## Best Practices

- Keep agents narrow and task-specific.
- Log every tool use.
- Require validation before side effects.
- Add explicit stopping conditions.
- Review agent output before production actions.

## Summary

Agentic workflows let AI systems plan, use tools, and iterate across multiple steps. They are powerful, but they demand stronger orchestration and guardrails than simple chat interactions. Treat the agent as a controlled workflow, not as a magical autonomous employee.

## Further Reading

- OpenAI or similar agent orchestration guides
- LangChain and LlamaIndex documentation
- Papers on planning, tool use, and agent safety
