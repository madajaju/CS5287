# AI as a Thinking Partner in Software Development

Video: https://youtu.be/ci1Gn0JF8HE

## Learning Objectives

By the end of this lecture, students will be able to:

- **Explain** why AI output should be treated as a draft rather than evidence.
- **Identify** common failure modes in AI-generated code, explanations, and citations.
- **Analyze** AI-assisted designs for concurrency risks such as race conditions and duplicate side effects.
- **Design** a verification workflow that checks AI claims against tests, logs, and documentation.
- **Compare** productive AI use with uncritical AI outsourcing.
- **Apply** responsible AI disclosure practices in course assignments and professional work.
- **Defend** an AI-assisted design decision using an Individual Integrity Packet.

## Prerequisites

Students should already understand:

- Basic object-oriented design
- Unit testing and test-driven thinking
- Version control workflows
- Basic concurrency concepts, especially shared state and race conditions
- Reading and writing simple Python code
- Responsible AI disclosure requirements for coursework

> **Assumption:** The examples in this lecture use Python because the original README’s worked example uses Python-like code.

---

## Big Picture Overview

AI tools are now common in software development. Developers use them to draft code, summarize documentation, suggest tests, explain unfamiliar APIs, and brainstorm designs. That can be very helpful—but it also creates a dangerous illusion: fluent output can look correct even when it is wrong.

This lecture addresses a practical engineering problem:

> **How do we use AI to accelerate thinking without letting it replace engineering judgment?**

This matters because in real projects, software must be:

- **Correct** under real conditions, not just in a simple example
- **Maintainable** by other engineers later
- **Testable** with evidence, not guesses
- **Safe** under concurrency, retries, partial failures, and stale state
- **Defensible** during reviews, audits, and team discussions

In this course, the issue is especially important because concurrent systems often fail in ways that AI-generated code does not naturally anticipate. A function that looks fine in a single-threaded test may break badly when two workers process the same entity at the same time.

### Why this topic matters in practice

You will encounter this problem whenever you:

- ask AI to generate boilerplate and then adapt it to a real system
- use AI to explain code you do not yet understand
- rely on AI for “best practices” in architecture or testing
- build systems with background jobs, queues, retries, or multiple users editing the same data
- need to justify your implementation choices in a code review or oral defense

The core lesson is simple:

> AI can help you think faster, but it cannot be trusted to verify itself.

---

## Core Concepts

## 1) AI as Draft, Not Evidence

### Definition
AI output is a **proposed artifact**—a code snippet, explanation, design idea, or test suggestion—that must be verified before use.

### Why it exists
AI models generate plausible text based on patterns in their training data and prompt context. They do **not** execute your system, inspect your database, or magically know your project invariants unless you explicitly provide them.

Think of AI output as a **first-pass hypothesis**. It may be useful, but it is not proof.

### When to use it
Use AI output as a starting point for:

- brainstorming design alternatives
- drafting boilerplate
- generating test ideas
- summarizing unfamiliar concepts
- asking for critique of a design

### When not to use it
Do **not** treat AI output as final when:

- the code affects shared state
- the system has concurrency requirements
- correctness depends on hidden business rules
- the response includes API claims or citations that need verification
- the answer is used in an assignment requiring student ownership

### Common mistakes or misconceptions
- “It sounds confident, so it must be correct.”
- “The code compiled once, so the design is safe.”
- “The AI said it handles edge cases.”
- “I can cite the AI explanation as if it were a source.”
- “If it worked in the demo, it’s production-ready.”

### Simple example

```python
def publish_episode(episode_id):
    episode = load_episode(episode_id)
    if episode.status == "draft":
        episode.status = "published"
        save_episode(episode)
        notify_subscribers(episode_id)
```

This may be a decent draft, but it is **not proof** that publishing is safe under concurrent workers.

### Teaching note
A useful instructor phrase here is:

> “AI can propose. The engineer must prove.”

---

## 2) Productive AI Use

### Definition
Productive AI use means using AI to **expand thinking**, not replace it.

### Why it exists
AI can help developers explore more options faster:

- alternative designs
- edge cases
- tradeoffs
- test ideas
- refactoring suggestions
- “what could go wrong?” checks

In other words, AI is best as a **thinking partner**. It helps you widen the search space, but it should not be the final decision-maker.

### When to use it
Use AI when you want to:

- generate multiple options
- challenge assumptions
- explain unfamiliar material in simpler terms
- create a first-pass test plan
- review a design from another angle

### When not to use it
Avoid using AI as the final authority when:

- you need a guarantee
- the response must be source-grounded
- the system is safety-critical
- the feature has concurrency or distributed-system implications

### Common mistakes or misconceptions
- Asking only for code, not for risks
- Accepting the first answer without critique
- Not providing enough context
- Failing to ask for failure cases
- Using AI output without running tests

### Simple example

A stronger prompt might be:

> “Suggest three ways to implement publishing an episode safely under concurrent workers. For each, list the invariant it protects, the failure case it prevents, and what test I should run to validate it.”

That prompt turns AI into a reasoning partner instead of an answer machine.

### When this is especially useful
AI is often productive when used for:

- generating a checklist of edge cases
- comparing two architecture approaches
- writing the first draft of unit tests
- translating a concept into plain language
- suggesting refactorings you can review manually

---

## 3) AI Failure Modes

### Definition
AI failure modes are recurring ways AI-generated output becomes incorrect, incomplete, misleading, or unsafe.

### Why it exists
AI is optimized to produce plausible output, not guaranteed-correct output. Common failure modes include:

- hallucinated APIs
- invented citations
- missing edge cases
- mistaken assumptions about execution order
- ignoring local project constraints
- shallow explanations of failure behavior

### When to use it
You do not “use” failure modes directly—you design your workflow to detect them.

### When not to use it
Do not assume AI can reliably:

- infer your database transaction model
- understand your architecture without being told
- correctly reason about concurrency by default
- validate claims without tests or references

### Common mistakes or misconceptions
- “The model knows best practices.”
- “If it mentions a library, the library must exist.”
- “If it includes a citation, the citation must be real.”
- “If the explanation is coherent, it must be complete.”
- “If the code looks idiomatic, it must be safe.”

### Simple example
An AI response might recommend an API that does not exist in your version of a library. The text looks professional, but the implementation fails immediately when you try to use it.

### Practical takeaway
When reviewing AI output, ask:

- What assumptions is this making?
- What would fail first in production?
- Which claims can I verify with docs or tests?
- What might be missing because the model did not know my system context?

---

## 4) The Concurrency Blind Spot

### Definition
The concurrency blind spot is the tendency for AI-generated reasoning to assume operations happen one at a time unless concurrency is explicitly stated and tested.

### Why it exists
Many AI-generated solutions are based on common sequential examples. In real systems, though, multiple workers, threads, processes, or retries may overlap. That changes everything.

A check like “if status is draft, then publish it” is often fine in a toy example, but under concurrent execution it may not be safe.

### When to use it
Use this concept whenever AI suggests code that:

- reads state
- makes a decision
- writes state
- sends an email, event, or notification
- assumes one operation will happen before another

### When not to use it
Never ignore it in:

- background jobs
- message processing
- state transitions
- inventory systems
- payment or publishing workflows
- any shared mutable state

### Common mistakes or misconceptions
- “If the if-statement is correct, the function is correct.”
- “A check-before-save is enough.”
- “The side effect only happens once in normal testing.”
- “Retries are harmless.”
- “Single-user correctness implies multi-user correctness.”

### Simple example

Two workers read `draft` at the same time and both publish the same episode. If the function is not atomic or idempotent, both may send notifications.

### Why this is dangerous
Concurrency bugs often show up only under load, which means:

- they are harder to reproduce
- they are harder to debug
- they often pass unit tests
- they can cause duplicate side effects or data corruption

---

## 5) Individual Integrity Packet

### Definition
An Individual Integrity Packet is a structured record showing how AI was used, what was accepted or rejected, what evidence was collected, and how the student owns the final work.

### Why it exists
The goal is not merely to disclose AI use. The goal is to show:

- what the AI contributed
- what the student rejected
- what the student verified
- why the final decision is sound

This is important both academically and professionally. In a team setting, this is similar to documenting design decisions in a pull request, architecture note, or incident review.

### When to use it
Use it in assignments that require responsible AI disclosure or oral defense, especially when AI helped with design, code, tests, or explanations.

### When not to use it
Do not use it as a substitute for understanding. A packet filled with transcripts but no critique is weak evidence.

### Common mistakes or misconceptions
- Logging prompts without analysis
- Copying output without validation
- Failing to distinguish accepted vs. rejected suggestions
- Treating disclosure as if it were ownership
- Thinking “I disclosed it” is the same as “I understood it”

### Simple example
A good packet entry includes:

- prompt used
- AI response summary
- critique of missing assumptions
- test results
- final decision
- student reflection

### Why it helps
The packet makes your reasoning visible. It helps instructors, reviewers, and future you understand:

- how the design evolved
- what evidence supports the final solution
- where AI was helpful and where it was not

---

## Design Pattern Connections

This lecture is about AI-assisted reasoning, not a classic “design pattern” topic. However, several patterns strongly connect to the workflow and architectural decisions discussed here.

## 1) Strategy Pattern

### Problem it solves
Strategy lets you swap one algorithm or policy for another without changing the calling code.

### Connection to this lecture
AI is often best used to generate or compare **strategies**:

- different publishing rules
- different retry policies
- different validation approaches

When asking AI for design options, you are often really asking it to help compare strategies.

### Example

```python
class PublishStrategy:
    def publish(self, episode):
        raise NotImplementedError

class ImmediatePublishStrategy(PublishStrategy):
    def publish(self, episode):
        episode.status = "published"

class ScheduledPublishStrategy(PublishStrategy):
    def publish(self, episode):
        if episode.publish_at <= now():
            episode.status = "published"
```

### Real-world use
- pricing rules
- notification delivery policies
- retry/backoff strategies
- authorization policies

### Why it matters here
A good AI prompt might ask for multiple strategy options and the tradeoffs of each. A weak prompt asks only for one “best” answer.

---

## 2) Observer Pattern

### Problem it solves
Observer coordinates side effects when something changes.

### Connection to this lecture
The publish example includes notifications. If AI suggests “save then notify,” you must ask whether notification should happen:

- synchronously or asynchronously
- once or many times
- with retry handling
- only after a successful atomic transition

Observer is relevant because AI-generated code often forgets to model side effects as separate concerns.

### Example

```python
class EpisodePublisher:
    def __init__(self):
        self.subscribers = []

    def subscribe(self, listener):
        self.subscribers.append(listener)

    def publish(self, episode):
        episode.status = "published"
        for listener in self.subscribers:
            listener(episode)
```

### Real-world use
- event-driven systems
- UI updates
- domain events
- webhook notification systems

### Caution
If observers perform side effects, you must think about retries, idempotency, ordering, and failure isolation.

---

## 3) Template Method Pattern

### Problem it solves
Template Method defines a fixed workflow with customizable steps.

### Connection to this lecture
The lecture’s verification workflow resembles a template:

1. ask AI for a draft
2. critique it
3. validate claims
4. revise
5. record evidence

This is a good mental model for responsible AI use: the overall workflow is fixed, but the details of each step may vary by assignment or project.

### Example

```python
class AiAssistedWorkflow:
    def run(self):
        draft = self.ask_ai()
        critique = self.review(draft)
        evidence = self.validate(draft)
        return self.finalize(draft, critique, evidence)

    def ask_ai(self):
        raise NotImplementedError
```

### Real-world use
- code review workflows
- build pipelines
- data processing pipelines
- verification checklists

### Why it matters here
A structured workflow prevents “ask AI, paste answer, move on” behavior.

---

## 4) Dependency Injection

### Problem it solves
Dependency Injection makes it easier to swap implementations and test behavior.

### Connection to this lecture
AI-generated suggestions often ignore testability. Injecting dependencies makes concurrency-safe code easier to verify.

### Example

```python
class EpisodeService:
    def __init__(self, repository, notifier):
        self.repository = repository
        self.notifier = notifier

    def publish(self, episode_id):
        episode = self.repository.load(episode_id)
        if episode.status == "draft":
            episode.status = "published"
            self.repository.save(episode)
            self.notifier.send_published(episode_id)
```

### Real-world use
- service layers
- test doubles/mocks
- database access
- email and message delivery

### Why it matters here
Dependency Injection makes it easier to test:
- whether the repository save happens once
- whether the notifier is called only after success
- whether the service behaves correctly under concurrent conditions

---

## 5) Facade Pattern

### Problem it solves
Facade provides a simplified interface to a complex subsystem.

### Connection to this lecture
AI often acts like a facade for knowledge: it gives a clean answer over a complex area. That is useful, but it can hide missing detail.

### Example
A developer asks AI:
> “How do I make this safe?”

The AI gives a short answer, but the real system involves:
- database transactions
- message queues
- retries
- locks
- idempotency

### Real-world use
- SDKs
- service wrappers
- user-friendly APIs

### Lesson
A facade is helpful only if you remember there is complexity behind it. AI can be treated as a helpful facade for exploration, but not for final verification.

---

## Code Examples

## Example 1: Naive AI-Assisted Publish Function

### Scenario
A student asks AI to improve a publish function for a podcast episode.

### Code

```python
def publish_episode(episode_id):
    episode = load_episode(episode_id)
    if episode.status == "draft":
        episode.status = "published"
        save_episode(episode)
        notify_subscribers(episode_id)
```

### Step-by-step walkthrough
1. Load the episode from storage.
2. Check whether it is still in `draft`.
3. Change its status to `published`.
4. Save the updated episode.
5. Notify subscribers.

### What problem it solves
It performs the basic business workflow of publishing content.

### Tradeoffs
- Simple and readable
- Easy to test in a single-threaded scenario
- Unsafe if multiple workers can publish the same episode
- Notification may occur more than once

### Production evolution
In production, this would likely need:

- atomic state transition
- version checking or locking
- idempotent notification
- retry-safe messaging
- audit logging

### Instructor note
This is a strong “looks right, but is it?” example. Students often accept it quickly, which makes it ideal for discussion.

---

## Example 2: Safer Publish Flow with Atomic Transition

### Scenario
We want to ensure only one worker successfully publishes an episode.

### Code

```python
def publish_episode(episode_id, expected_version):
    changed = transition_status(
        episode_id,
        from_status="draft",
        to_status="published",
        expected_version=expected_version
    )
    if changed:
        notify_subscribers_once(episode_id)
```

### Step-by-step walkthrough
1. The caller provides an expected version.
2. `transition_status(...)` attempts the state change atomically.
3. Only one caller should succeed if the record has not changed.
4. Notification runs only after a successful transition.
5. `notify_subscribers_once(...)` should be idempotent.

### What problem it solves
It reduces the chance of duplicate publishing and duplicate side effects.

### Tradeoffs
- More complex than the naive version
- Requires support from the persistence layer
- Still depends on the correctness of the atomic transition
- May need database constraints or transaction support

### Production evolution
A real system might implement this with:

- SQL `UPDATE ... WHERE status = 'draft' AND version = ?`
- row-level locking
- optimistic concurrency control
- an event log or outbox pattern for notifications

### Why this matters
This example shows a general engineering principle:

> Correctness often comes from combining state checks with atomic updates, not from “if” statements alone.

---

## Example 3: Verification Workflow for AI-Suggested Code

### Scenario
A student wants a repeatable workflow for checking AI output.

### Code

```python
def verify_ai_suggestion(suggestion, tests, docs):
    report = {
        "claimed_features": [],
        "verified": [],
        "rejected": [],
    }

    for claim in suggestion.claims:
        if claim in docs:
            report["verified"].append(claim)
        else:
            report["rejected"].append(claim)

    test_results = tests.run()
    report["test_results"] = test_results
    return report
```

### Step-by-step walkthrough
1. Treat the AI suggestion as a set of claims.
2. Compare claims against documentation.
3. Run tests.
4. Record verified and rejected claims.
5. Produce a report for the integrity packet.

### What problem it solves
It makes AI review explicit and documented rather than informal.

### Tradeoffs
- Requires discipline
- Documentation and tests must actually exist
- Not every claim is directly machine-checkable
- Human judgment is still required

### Production evolution
This idea scales into:

- code review checklists
- CI validation gates
- evidence-based approvals
- audit-friendly engineering processes

### Improvement note
In real code, you would likely model claims more carefully. For example, a claim might be:

- “This function is idempotent”
- “This notification is sent exactly once”
- “This API exists in version 2.1”

Each of those requires different evidence.

---

## Example 4: Testable Service Design with Dependency Injection

### Scenario
We want to verify that publish logic calls the repository and notifier in the correct order.

### Code

```python
class EpisodeService:
    def __init__(self, repository, notifier):
        self.repository = repository
        self.notifier = notifier

    def publish(self, episode_id):
        episode = self.repository.load(episode_id)

        if episode.status != "draft":
            return False

        episode.status = "published"
        self.repository.save(episode)
        self.notifier.send_published(episode_id)
        return True
```

### Step-by-step walkthrough
1. The service receives repository and notifier objects.
2. It loads the episode from the repository.
3. It refuses to publish if the episode is not in draft.
4. It updates and saves the episode.
5. It triggers a notification.
6. It returns success/failure for easier testing.

### What problem it solves
This isolates side effects behind interfaces, making the behavior easier to test and reason about.

### Tradeoffs
- More setup than a simple function
- Still needs concurrency protection
- Requires mocks or test doubles
- Business rules may become more complex over time

### Production evolution
This structure can evolve to include:

- transaction boundaries
- audit events
- retry policies
- idempotency keys
- domain events or an outbox table

---

## Real-World Examples

## 1) E-commerce Order Processing

### System
An online store processes orders, charges payments, updates inventory, and sends receipts.

### Problem being solved
AI may suggest a straightforward “charge then save order” flow. But if two workers or retries occur, the system can double-charge, double-decrement inventory, or send duplicate receipts.

### How the concept applies
AI should be used to brainstorm:

- idempotency keys
- transactional boundaries
- retry-safe APIs
- inventory reservation strategies

### Tradeoffs or risks
- stronger consistency may reduce throughput
- idempotency adds complexity
- distributed transactions may be costly or unavailable
- duplicate emails may frustrate customers and support teams

### Typical lesson
A solution that looks elegant in AI output may still be operationally unsafe.

---

## 2) Banking and Finance

### System
A banking application transfers money between accounts and generates transaction records.

### Problem being solved
An AI-generated solution may look elegant but fail under concurrent transfers or partial failure.

### How the concept applies
AI suggestions must be checked against:

- atomic balance updates
- ledger correctness
- audit requirements
- rollback behavior
- regulatory constraints

### Tradeoffs or risks
- consistency and auditability matter more than simplicity
- incorrect concurrency logic can create financial loss
- a fluent explanation is not evidence of correctness
- compliance requirements may demand logs and traceability

### Typical lesson
In finance, “probably works” is not acceptable. Verification and traceability matter as much as code quality.

---

## 3) Healthcare Scheduling

### System
A hospital scheduling system books appointments and notifies patients.

### Problem being solved
AI may propose a scheduling function that works in isolation but breaks when two staff members schedule the same slot at once.

### How the concept applies
Use AI to help explore:

- conflict detection
- locking strategies
- notification timing
- cancellation handling
- fallback behavior when integrations fail

### Tradeoffs or risks
- overbooking can harm patients and staff
- notification duplicates can confuse users
- privacy requirements may restrict logging and AI usage
- stale availability data can produce bad scheduling decisions

### Typical lesson
Human lives and operational reliability raise the bar for correctness and evidence.

---

## 4) SaaS Subscription Management

### System
A software-as-a-service platform upgrades subscriptions, applies prorations, and sends billing events.

### Problem being solved
AI can generate a clean subscription update method, but billing often involves retries, delayed webhook delivery, and eventual consistency.

### How the concept applies
You must consider:

- idempotent billing events
- versioned subscription state
- safe retries
- separation of billing and notification responsibilities

### Tradeoffs or risks
- billing bugs can create support load or lost revenue
- duplicate billing events can violate trust
- reconciliation may be required if downstream services fail

### Typical lesson
AI helps with drafts, but billing logic must be verified like a critical system.

---

## Guided Walkthrough

## 1) How to Introduce the Topic
Start with the opening narrative:

- A student asks AI for help with a publish function.
- The code looks good and passes a simple test.
- Under concurrency, it fails.

Then ask:

> “If the code looked correct, why wasn’t it correct?”

This frames the lecture around evidence, not appearance.

## 2) What Analogy or Metaphor to Use
Use one of these metaphors:

- **AI is like a talented junior assistant who can draft ideas quickly, but cannot sign off on correctness.**
- **AI is a whiteboard, not a witness.**
- **AI is a brainstorming partner, not a judge.**

The strongest of these for most students is:

> “AI is a whiteboard, not a witness.”

A whiteboard helps you think, but it does not prove anything happened.

## 3) What Example to Build First
Begin with the naive `publish_episode` function. It is short, readable, and deceptively plausible. Then introduce the concurrent failure scenario. Finally, revise it into an atomic transition plus idempotent notification.

This progression teaches:

- why the first version seems fine
- what breaks in production
- how to design around the failure

## 4) What Questions to Ask Students
Ask:

- What assumption does this code make about execution order?
- What happens if two workers run this at the same time?
- What part of the AI output is a claim, and what is evidence?
- How would you test the claim?
- What would you log in the integrity packet?
- What would you reject from the AI response, and why?

## 5) What Common Student Confusion to Address
Students often think:

- “If AI gave me the idea, it must be acceptable.”
- “If a unit test passes, concurrency is fine.”
- “Disclosure means I’m done.”
- “If it works locally, it will work in production.”

Clarify that:

- AI is a suggestion source
- unit tests are necessary but not sufficient
- disclosure is only one part of ownership
- local success does not imply production correctness

## 6) How to Transition Into Deeper Material
Once students understand the simple publish example, extend the conversation to:

- retries
- distributed systems
- atomic database updates
- idempotent side effects
- code review and evidence-based decision-making
- assignment integrity requirements

This naturally leads into concurrency control, testing strategy, and professional documentation.

---

## Discussion Questions

1. Why is AI output more like a hypothesis than evidence?
2. What makes concurrency especially hard for AI-generated code to reason about?
3. How would you redesign the publish workflow to prevent duplicate notifications?
4. What should be included in an Individual Integrity Packet beyond the AI transcript?
5. When is AI most helpful in the software design process, and when is it risky?
6. How would you explain to a teammate why you rejected an AI suggestion?

---

## Common Pitfalls

## 1) Treating AI Output as Authority
### Mistake
Accepting AI code or explanations because they sound confident.

### Why it causes problems
Confidence is not correctness. This leads to hidden bugs, bad designs, and weak defenses in review.

### How to avoid it
Always ask: “What evidence supports this claim?” Run tests and verify assumptions.

---

## 2) Ignoring Concurrency
### Mistake
Assuming a function is correct because it works in a single-user or single-threaded scenario.

### Why it causes problems
Concurrent executions can duplicate side effects, corrupt state, or violate invariants.

### How to avoid it
Test interleavings, review shared state, and ask whether operations are atomic and idempotent.

---

## 3) Failing to Validate Claims
### Mistake
Using AI-generated APIs, citations, or technical claims without checking documentation.

### Why it causes problems
You may build on false assumptions and waste time debugging non-existent features.

### How to avoid it
Verify against primary sources, official docs, or executable tests.

---

## 4) Logging AI Use Without Critique
### Mistake
Saving the prompt and response, but not explaining what was accepted, rejected, or corrected.

### Why it causes problems
A transcript alone does not show ownership or reasoning.

### How to avoid it
Add critique, evidence, and revision notes to the AI usage record.

---

## 5) Letting AI Replace Student Understanding
### Mistake
Copying a solution without internalizing it.

### Why it causes problems
The student cannot defend the work in oral review or real-world discussion.

### How to avoid it
Rewrite the solution in your own words and be able to explain the tradeoffs.

---

## 6) Assuming “Edge Cases” Will Be Mentioned Automatically
### Mistake
Using AI output without explicitly asking about failures, retries, concurrency, or invalid input.

### Why it causes problems
The model may produce a clean happy-path solution and omit the risky parts.

### How to avoid it
Prompt for failure modes directly:
- “What can go wrong?”
- “What if two requests happen at once?”
- “What if this operation is retried?”

---

## Best Practices

- **Ask AI for alternatives, not just answers.**
- **Require the AI to state assumptions and risks.**
- **Verify code with tests before accepting it.**
- **Check AI-generated claims against primary documentation.**
- **Explicitly review shared state and concurrency behavior.**
- **Document accepted, rejected, and verified suggestions.**
- **Use idempotency and atomic transitions when side effects matter.**
- **Treat AI as a collaborator, not a substitute for engineering judgment.**
- **Keep the final design explainable without the transcript in front of you.**
- **Record evidence in the Integrity Packet, not just opinions.**
- **Ask for failure cases before asking for final code.**
- **Prefer designs that are easy to test and observe.**
- **When possible, verify with automated tests, not just manual inspection.**

---

## Summary

AI can be a powerful thinking partner in software development, but it is not a source of truth. Its output should be treated as a draft that must be validated against tests, documentation, and system constraints.

The most important ideas in this lecture are:

- **AI as Draft, Not Evidence**
- **Productive AI Use**
- **AI Failure Modes**
- **The Concurrency Blind Spot**
- **Individual Integrity Packet**

These matter because software must be correct under real-world conditions, not just plausible in conversation. In future work, students should use AI to explore ideas faster, but always verify the results, especially when shared state, concurrency, or side effects are involved.

The professional mindset to remember is:

> AI can help you think, but engineering judgment must decide.

---

## Further Reading

### Course Resources
- [AI Usage Log Template](../../../assignments/shared/ai-usage-log-template.md)
- [Integrity Packet Template](../../../assignments/shared/integrity-packet-template.md)
- [A0 - Project Selection, Environment & Integrity Packet](../../../assignments/A0/index.md)
- [A1 - Object Model Under Concurrency](../../../assignments/A1/index.md)

### Official Documentation and References
- Python documentation for threading, multiprocessing, and `asyncio`
- Database documentation for transactions and isolation levels
- Documentation for your testing framework
- Official docs for any libraries used in your project

### Books
- *Design Patterns: Elements of Reusable Object-Oriented Software* — Gamma, Helm, Johnson, Vlissides
- *Clean Code* — Robert C. Martin
- *Release It!* — Michael T. Nygard
- *Designing Data-Intensive Applications* — Martin Kleppmann

### Articles and Topics to Explore
- AI-assisted software engineering verification
- Code review checklists for generated code
- Idempotency in distributed systems
- Optimistic concurrency control
- Atomic state transitions
- Responsible AI use in software engineering education

### Design Pattern References
- Strategy
- Observer
- Template Method
- Dependency Injection
- Facade

### Suggested instructor follow-up topics
- Outbox pattern
- Retry safety
- Eventual consistency
- Logging and observability
- Mocking vs. integration testing
- Human-in-the-loop review workflows

If you want, I can also turn this into a **slide deck outline**, **classroom activity sheet**, or **assignment prompt with rubric**.