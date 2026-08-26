# Final Project Demonstration and Technical Defense

## Learning Objectives

- Demonstrate the completed individual project and trace its end-to-end data flow.
- Defend architecture and reference-stack decisions using evidence and trade-offs.
- Explain how the system evolved from CA0 through CA4.
- Evaluate reliability, security, observability, and operational limitations.
- Communicate lessons learned and identify realistic next steps.

## Course Context

There is no separate formal proposal, team presentation, or paper. The reference stack selected and documented at the
start of CA0 is the planning decision for the semester project. Each student develops that stack individually through
CA0–CA4.

Week 14 is the culmination of that work. Students present the completed CA4 system, demonstrate its behavior, and
defend their engineering decisions with evidence from the repository and Integrity Packet.

## Demonstration Structure

### 1. Problem and System Overview

Briefly explain:

- what the pipeline does
- who or what uses it
- the selected reference-stack components
- the deployment topology

### 2. Architecture and Evolution

Show the final architecture diagram and explain how the system changed across the assignments:

- CA0: manual deployment
- CA1: infrastructure as code
- CA2: container orchestration
- CA3: observability, scaling, security, and resilience
- CA4: multi-site or multi-cloud operation

Focus on decisions and trade-offs rather than listing tools.

### 3. Live or Recorded Demonstration

Demonstrate:

- end-to-end data flow
- the required REST endpoint
- connectivity across the CA4 topology
- observability evidence
- one resilience or recovery scenario

Use the externally hosted CA4 video as a fallback if a live demonstration is not reliable.

### 4. Evidence and Integrity Packet

Connect major claims to evidence such as:

- test output
- logs, metrics, and dashboards
- configuration or infrastructure code
- failure and recovery results
- documented assumptions
- verified, rejected, or revised AI guidance

### 5. Technical Defense

Be prepared to answer questions about:

- why the selected architecture fits the problem
- alternatives considered
- security boundaries and remaining risks
- scaling and failure behavior
- limitations and unfinished work
- what you would change in a production implementation

### 6. Reflection

Conclude with the most important lessons learned while moving from a manual deployment to the final architecture.
Identify one technically justified next step.

## Individual Work

The final project demonstration is individual. Class discussion and peer feedback are encouraged, but the design,
implementation, evidence, Integrity Packet, demonstration, and technical defense must be the presenting student's own
work.

## Common Pitfalls

- Showing tools without explaining the system or data flow
- Making claims without logs, tests, metrics, or other evidence
- Omitting the REST endpoint from the demonstration
- Presenting only the happy path without discussing failure behavior
- Reading documentation instead of defending engineering decisions
- Treating AI-generated explanations as evidence without verification

## Preparation Checklist

- Confirm the repository and video links are accessible to the instructor.
- Rehearse the end-to-end demonstration.
- Prepare the final architecture diagram.
- Select concise evidence for each major claim.
- Review the Integrity Packet and unresolved risks.
- Test the REST endpoint and resilience scenario.
- Prepare for technical follow-up questions.
