# Introduction to Chaos Engineering

Video: https://youtu.be/TLvi73dfgJw

## 1. Introduction & Motivation
1. **Opening Scenario**
    - Imagine a sudden regional outage at your cloud provider: DNS stops resolving, database replicas lose sync, and customers flood social media with errors.
    - How prepared is your architecture?

2. **Learning Objectives**
    - Understand why chaos experiments are critical in modern distributed systems.
    - Learn the methodology behind designing and running safe, meaningful chaos tests.
    - Explore popular tools and real-world examples to apply chaos practices in your environment.

## 2. What Is Chaos Engineering?
- **Definition Recap** “A discipline of experimenting on a system to build confidence in its ability to withstand turbulent conditions in production.”
- **Key Insights**
    1. **Controlled Experiments:** Not random breakage, but carefully scoped tests.
    2. **Data-Driven:** Hypotheses are validated against metrics (SLA, latency, error rates).
    3. **Continuous Feedback Loop:** Incorporate learnings into design, deployments, and runbooks.

## 3. Why Chaos in the Cloud?
- **Dynamic Environments**
    - Autoscaling groups, container orchestrators, serverless functions—systems evolve in real time.
    - Traditional load tests fall short capturing non-functional failures.

- **Hidden Coupling**
    - Shallow dependencies and shared libraries can cascade failures in unexpected ways.

- **Cost of Downtime**
    - Gartner estimates unplanned outages cost ~$5,600 per minute on average.
    - Proactive resilience reduces business and reputational risk.

## 4. The Four-Step Chaos Engineering Process
1. **Define Steady State**
    - Examples:
        - “API success rate ≥ 99.9%”
        - “Mean response time < 200ms under 1,000 RPS.”

2. **Form Hypothesis**
    - “If one availability zone fails, our global load balancer reroutes traffic and error rate stays <0.1%.”

3. **Introduce Variables & Run Experiments**
    - **Variables:** CPU throttling, pod eviction, network partitions, DB failover.
    - **Execution Modes:** Manual kick-off, scheduled jobs, CI/CD pipelines.

4. **Observe, Learn, and Improve**
    - Collect logs, metrics, tracing spans (OpenTelemetry).
    - Update runbooks, adjust auto-scaling, add caching/CDN layers, implement bulkheads.

## 5. Failure Modes and Their Impacts

| Failure Mode | Real-World Consequence | Mitigation Pattern |
| --- | --- | --- |
| VM / Container Kill | Sudden drop in capacity; in-flight requests aborted | Graceful shutdown hooks; retries |
| Network Latency / Loss | Timeouts, head-of-line blocking | Circuit breakers; client timeouts |
| Resource Exhaustion | CPU spikes, memory leaks leading to OOM kills | Resource quotas; autoscaling |
| Dependency Downtime | Cascading failures if synchronous calls are unbounded | Bulkheads; async communication |
| Zone / Region Outage | Complete loss of a data center region | Multi-region failover; DNS TTL |
## 6. Tools & Ecosystem Deep Dive
1. **Chaos Monkey (Netflix)**
    - Part of the Simian Army suite; focuses on instance termination in AWS.
    - Best used in autoscaled environments where instance replacement is automated.

2. **Gremlin**
    - Rich fault library: CPU, memory, disk, network.
    - Role-based access control and blast-radius management.

3. **LitmusChaos**
    - Kubernetes-native experiments as CRDs and controllers.
    - Integrates with Prometheus, Grafana for monitoring.

4. **Cloud Provider Offerings**
    - **AWS Fault Injection Simulator:** GUI and API-driven chaos; integrates with CloudWatch, X-Ray.
    - **Azure Chaos Studio:** Step-based experiments; permission scopes per resource group.
    - **Google Cloud Resilience Toolkit:** Policy-driven fault injection, chaos scheduling.

## 7. Designing Effective Experiments
1. **Select the Right Environment**
    - **Dev / QA / Staging:** Safe playground but may not mirror production scale.
    - **Production Canary:** Target a small % of users or non-critical services.

2. **Scope & Blast Radius**
    - Narrow scope: single pod, single VM, one AZ.
    - Progressive rollout: ramp up from 1% to 10% to 100% only after success gates.

3. **Instrumentation & Monitoring**
    - Ensure end-to-end tracing (distributed traces).
    - Dashboard with real-time and historical comparisons.

4. **Safety Mechanisms**
    - Abort switches (manual or automated if metrics exceed thresholds).
    - Timeouts on experiments to prevent runaway scenarios.

5. **Documentation & Communication**
    - Pre-experiment runbook: goals, scope, metrics, rollback plan.
    - Post-experiment report: findings, issues, next steps.

## 8. Real-World Case Studies
### A. Global E-Commerce Platform
- **Challenge:** Intermittent slow checkout during peak sales.
- **Experiment:** Introduce 200ms latency to the inventory service (`toxiproxy`).
- **Outcome:**
    - Order service fell back to stale cache successfully 95% of the time.
    - Identified a missing circuit-breaker; added Hystrix with fallback strategy.

### B. Video-Streaming Service
- **Challenge:** One region experienced DB failover a few times per month, causing buffering.
- **Experiment:** Simulate master DB crash in staging.
- **Outcome:**
    - Discovered connection-pool exhaustion during failover—tuned HikariCP settings.
    - Reduced failover recovery time from 2 minutes to 30 seconds.

## 9. Organizational & Cultural Considerations
- **Cross-Functional Collaboration**
    - SREs, developers, security, and product owners align on risk tolerances.

- **Blameless Postmortems**
    - Document both successes and failures of chaos experiments.

- **Training & Hackathons**
    - Internal “resilience days” to practice chaos drills and game days.

- **Governance & Policy**
    - Define which services can be tested, who approves experiments, and reporting cadence.

## 10. Measuring Impact & ROI
- **Quantitative Metrics:**
    - Reduction in severity/number of incidents.
    - Faster Mean Time To Detect (MTTD) and Mean Time To Recover (MTTR).

- **Qualitative Outcomes:**
    - Increased developer confidence in deployments.
    - Stronger collaboration between dev and ops teams.

- **Business Value:**
    - Improved uptime leads to higher customer satisfaction and revenue protection.
    
### References & Further Reading

Netflix’s Chaos Engineering Principles
– URL: https://principles.chaosmonkey.io
– This is the official site where Netflix details the guiding principles behind Chaos Monkey and Chaos Engineering.
Gremlin Tutorials
– URL: https://www.gremlin.com/docs/
– Gremlin’s documentation hub, which includes guides to get started with their chaos engineering platform.
“The Practice of Cloud System Administration” (Book)
– Author: Thomas A. Limoncelli, Strata R. Chalup, and Christina J. Hogan
– Published by Addison-Wesley Professional in 2014 (ISBN-13: 978-0133399937)
– This book covers operational best practices for running and managing cloud services, including resilience techniques.