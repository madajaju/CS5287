# Final Project

## Learning Objectives

- Design a project proposal with a clear problem statement and scope.
- Compare architecture options and justify a selected approach.
- Define milestones, validation steps, and a demo plan.
- Explain how evidence, assumptions, and risk management shape the proposal.
- Prepare a presentation that defends engineering decisions clearly.

## Prerequisites

- All prior course material
- Comfort with cloud architecture and deployment concepts
- Familiarity with documentation and technical presentations

## Big Picture Overview

The final project is where the course shifts from learning individual cloud technologies to integrating them into one coherent system and argument. The goal is not just to build something that works, but to explain why it works, what trade-offs were made, and what evidence supports the design.

This is the point where engineering maturity matters most. Students must narrow scope, choose a realistic architecture, and present results in a way that another engineer can evaluate.

## Core Concepts

### 1. Problem Statement

Define the exact problem the project solves.

Why it exists:
- Good projects start with a clear need, not a random tool choice.

When to use it:
- At the start of every project

Common mistake:
- Describing a technology stack instead of a problem.

### 2. Scope and Constraints

Identify what the project will and will not do.

Why it exists:
- A good project is finite and defensible.

When to use it:
- Before implementation starts

Common mistake:
- Trying to solve every related problem at once.

### 3. Architecture Choices

Explain the major components and how they interact.

Why it exists:
- The architecture is the argument for how the system works.

When to use it:
- In the proposal, the build, and the final presentation

Common mistake:
- Drawing boxes without explaining the flow between them.

### 4. Evidence and Validation

Use logs, screenshots, tests, and metrics to support claims.

Why it exists:
- A project is only credible if it can be checked.

When to use it:
- Throughout development

Common mistake:
- Saving only the final happy-path screenshot.

### 5. Milestones and Demo Plan

Break the project into reachable stages.

Why it exists:
- Milestones keep the project from drifting.

When to use it:
- As soon as the scope is defined

## Design Pattern Connections

### Builder

The final project proposal is a builder-style artifact.

Problem solved:
- Lets a complex deliverable be assembled incrementally.

Relation to the project:
- Scope, architecture, evidence, and demo plan all accumulate over time.

### Strategy

Different architecture choices are strategies.

Problem solved:
- Lets the team compare more than one possible design before committing.

### Repository

Project evidence acts like a repository of engineering truth.

Problem solved:
- Keeps logs, results, and artifacts organized for review.

## Code Example

### Scenario

Track project milestones and whether each one is complete.

### Code

```python
milestones = [
    {"name": "proposal", "done": True},
    {"name": "prototype", "done": False},
    {"name": "validation", "done": False},
    {"name": "demo", "done": False},
]

for item in milestones:
    status = "done" if item["done"] else "pending"
    print(f"{item['name']}: {status}")
```

### Walkthrough

1. Store milestones as structured data.
2. Mark progress explicitly.
3. Review which pieces still need work.

### What Problem It Solves

This makes project progress visible and easy to discuss.

### Trade-offs

- Simple and transparent
- Easy to extend into a project tracker
- Not enough by itself without evidence and narrative

### Production Evolution

In practice, this would become a project board, evidence folder, demo checklist, and report outline.

## Real-World Examples

### 1. Cloud Migration Proposal

- Problem: move a service from on-prem to cloud
- Application: final project documents requirements, architecture, and validation
- Risk: scope creep and missing dependencies

### 2. Data Platform Modernization

- Problem: upgrade a batch pipeline to a cloud-native stack
- Application: proposal must compare alternatives and justify the choice
- Risk: choosing a design that is too large for the semester

### 3. AI Service Deployment

- Problem: deploy a model-backed service with monitoring and guardrails
- Application: final project must show architecture, validation, and safe operation
- Risk: model output quality and operational cost

## Guided Walkthrough

1. Start with the question: what problem are we solving?
2. Force a scope decision early.
3. Draw the architecture and trace the data flow.
4. Ask what evidence will prove success.
5. Address confusion between a demo and a final project.
6. Transition into milestone planning and presentation prep.

## Discussion Questions

1. What makes a project proposal credible?
2. How do you know if your scope is too large?
3. What evidence would convince a reviewer that the project works?
4. What should be included in a demo versus the written report?
5. How do architecture trade-offs affect feasibility?

## Common Pitfalls

### Too much scope

- Problem: the project becomes unfinishable.
- Avoid it: define the smallest version that still demonstrates learning.

### Too little evidence

- Problem: the project works, but nobody can tell why.
- Avoid it: save logs, tests, and screenshots continuously.

### Presentation without engineering detail

- Problem: the project sounds polished but is not technically defensible.
- Avoid it: tie every claim to architecture or evidence.

## Best Practices

- Start with a narrow problem.
- Compare alternatives before committing.
- Save evidence as you go.
- Present architecture and validation together.
- Keep the demo aligned with the stated goals.

## Summary

The final project is the synthesis of the course. Students should use cloud concepts, distributed systems thinking, and clear evidence to propose and present a coherent solution. The best final projects are narrow, well justified, and easy to defend.

## Further Reading

- Course assignment instructions
- Cloud architecture case studies
- Presentation and project planning references
