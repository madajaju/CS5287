# Observability in the Cloud

Video: https://youtu.be/xSoPSeQ9fIE

## Table of Contents
1. [Introduction](#1-introduction)  
2. [The Three Pillars](#2-the-three-pillars)  
3. [Core Concepts](#3-core-concepts)  
4. [Cloud-Native Tooling](#4-cloud-native-tooling)  
5. [Architecture Patterns](#5-architecture-patterns)  
6. [Best Practices](#6-best-practices)  
7. [Scaling Observability](#7-scaling-observability)  
8. [Alerting & Incident Response](#8-alerting--incident-response)  
9. [Case Study: E-Commerce Checkout](#9-case-study-e-commerce-checkout)  
10. [Further Reading & References](#10-further-reading--references)  

---

## 1. Introduction

Observability is the practice of instrumenting your software and infrastructure so you can **infer internal system behavior** from external signals.  
In cloud environments, this becomes critical because:
- Infrastructure is **ephemeral** and autoscaled.
- Services are **polyglot** and distributed across regions.
- Deployment velocity is high: you need rapid feedback loops.

---

## 2. The Three Pillars

1. **Metrics**  
   - Time-series data: CPU, memory, request rates, error counts.  
   - Stored in systems like [Prometheus](https://prometheus.io/), AWS CloudWatch.

2. **Logs**  
   - Timestamped events: application logs, access logs, audit trails.  
   - Aggregated by ELK stack (Elasticsearch, Logstash, Kibana), Cloud Logging.

3. **Distributed Tracing**  
   - Tracks request flows across microservices via spans and traces.  
   - Tools: [Jaeger](https://www.jaegertracing.io/), [Zipkin](https://zipkin.io/), AWS X-Ray.

---

## 3. Core Concepts

### 3.1 SLIs, SLOs, SLAs
- **SLI (Service Level Indicator)**: A measurable metric (e.g., 99th-percentile latency).  
- **SLO (Service Level Objective)**: Target for your SLI (e.g., 99% of requests < 200 ms).  
- **SLA (Service Level Agreement)**: Contractual commitment, often with penalties.

### 3.2 Telemetry Signals
- **Client-side vs. Server-side** instrumentation.  
- **[OpenTelemetry](https://opentelemetry.io/)**: Vendor-neutral standard for metrics, logs, and traces.

---

## 4. Cloud-Native Tooling

| Signal         | Tooling Examples                                   |
|----------------|----------------------------------------------------|
| Metrics        | Prometheus, AWS CloudWatch, Datadog                |
| Dashboards     | Grafana, CloudWatch Dashboards, Kibana             |
| Tracing        | Jaeger, Zipkin, AWS X-Ray                          |
| Logging        | Elasticsearch/Kibana, Splunk, Cloud Logging        |
| Alerting       | Prometheus Alertmanager, PagerDuty, Opsgenie       |

---

## 5. Architecture Patterns

1. **Sidecar / Agent**  
   - Deployed as a companion container (e.g., Envoy with OTel collector, Fluentd).

2. **DaemonSet / Node Agent**  
   - Runs on each node for host-level metrics/logs (e.g., Node Exporter, Filebeat).

3. **Push vs. Pull**  
   - **Push**: Agents send data to a collector.  
   - **Pull**: Monitoring system scrapes exporters at intervals.

---

## 6. Best Practices

- **Instrument Early**: Integrate metrics/tracing at project kickoff.  
- **Structured Logging**: Emit JSON or key/value pairs for easy parsing.  
- **Correlation IDs**: Propagate unique request IDs through logs & traces.  
- **Meaningful Tags**: Enrich telemetry with service, version, region, environment.  
- **Define SLIs/SLOs**: Focus on user-centric indicators (e.g., “checkout success rate”).  

---

## 7. Scaling Observability

- **High-Cardinality**: Avoid unbounded label values (user IDs) in metrics.  
- **Sampling**: Use head-based or tail-based sampling for traces to control volume.  
- **Retention Policies**: Balance cost vs. analysis needs for metrics, logs, traces.  
- **Multi-Tenant Isolation**: Partition telemetry by team or environment to prevent noisy neighbors.

---

## 8. Alerting & Incident Response

1. **Alerting Rules**  
   - Based on SLO burn rates, latency spikes, error budgets.

2. **On-Call Playbooks**  
   - Document standard operating procedures for common alerts.

3. **Runbooks & Automation**  
   - Automate remediation (e.g., auto-scaling, circuit breaker resets).

4. **Post-Mortems**  
   - Blameless retrospectives with root-cause analysis and action items.

---

## 9. Case Study: E-Commerce Checkout

- **SLI/SLO**:  
  - Checkout success rate ≥ 99.5% (over 5 min windows)  
  - 95th-percentile payment processing < 2 s

- **Metrics**:  
  - Instrument Prometheus counters for success/failure.  
  - Histogram for payment latency.

- **Tracing**:  
  - Correlate flows: Cart → Payment Gateway → Inventory Service.

- **Logging**:  
  - Log payment provider responses and error codes in structured JSON.

- **Dashboards & Alerts**:  
  - Grafana panel visualizing error budget and latency trends.  
  - Alert when success rate falls below SLO for > 3 minutes.

---

## 10. Further Reading & References

- OpenTelemetry Specification – https://opentelemetry.io/docs/  
- Prometheus Best Practices – https://prometheus.io/docs/practices/  
- Distributed Tracing Concepts – https://microservices.io/patterns/observability/distributed-tracing.html  
- Google SRE Book: Monitoring Distributed Systems – https://landing.google.com/sre/books/  
- “Site Reliability Engineering” (O’Reilly) – Chapter on SLIs, SLOs, SLAs  

---

*Prepared for CS5287 – Cloud Systems & Observability*
