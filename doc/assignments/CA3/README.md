# CA3 – Cloud-Native Ops: Observability, Scaling & Hardening

**Goal:** Operate your CA2 containerized pipeline as if it were a production service—instrumenting it for visibility, automating scaling, enforcing security controls, and proving resilience.

---

## Integrity Packet Requirement

Include an Integrity Packet with CA3. Record your observability claims, the metrics and logs that support them, the failure drills you ran, and any AI-generated suggestions you checked before adopting.

---

## 1. Observability

### Centralized Logging
- Deploy a log-collector (EFK: Elasticsearch / Fluentd / Kibana, ELK, or Loki + Grafana) as DaemonSet or sidecar.
- Configure Fluentd (or Promtail) to gather application logs from all pipeline pods (producer, broker, processor, DB).
- Ensure logs include timestamps, pod labels, and structured fields (e.g., “service: processor”, “topic: telemetry”).

### Metrics & Dashboards
- Install Prometheus for metrics collection and Grafana for visualization.
- Expose metrics endpoints:
    - **Producer rate**: events emitted/sec
    - **Kafka consumer lag**: `kafka_consumergroup_lag{group="processor"}`
    - **DB inserts/sec**: count of writes per second
    - **REST interface**: request rate, error rate, and latency for the required endpoint
- Create a Grafana dashboard with at least three panels showing these metrics over time.

**Deliverables:**
- Screenshot of log search (e.g., “error” filtered across components)
- Screenshot of Grafana dashboard with your three key metrics

---

## 2. Autoscaling

### Configure Horizontal Pod Autoscaler (K8s) or Swarm Scaling
- Define an HPA object targeting your producer Deployment (or equivalent):
    - Scale from 1 → N replicas based on CPU% or a custom metric (consumer lag).
- Optionally configure HPA for the processor tier.

### Load Test & Scale-Down
- Generate load (e.g., `kubectl run loadgen --image=load-generator …`) to push high event throughput.
- Observe HPA scaling events in `kubectl get hpa` or Swarm service scale.
- After load subsides, confirm pods scale back to minimum.

**Deliverables:**
- HPA manifest snippet and Swarm scale command
- Logs or screenshots of `kubectl get hpa` over time (or `docker service ls`)

---

## 3. Security Hardening

### Secrets Management
- Store DB and Kafka credentials as K8s `Secret` objects or Swarm secrets.
- Mount secrets into containers via environment variables or volumes.

### Network Isolation
- Define `NetworkPolicy` rules restricting pod-to-pod traffic:
    - Only the processor may talk to Kafka and DB ports.
    - Producers write only to Kafka.
- For Swarm, use overlay networks scoped to allowed services.

### TLS Encryption
- Enable TLS for:
    - Kafka listener (broker-to-broker and client).
    - MongoDB TLS connections.
    - Ingress or service-to-service communication.
- Use self-signed certificates managed by K8s `Secret` or a cert-manager.

**Deliverables:**
- NetworkPolicy YAML (or Swarm network diagram)
- Secret templates (sanitized) and TLS configuration summary

---

## 4. Resilience Drill

1. **Failure Injection**
    - Delete one pod in each tier (`kubectl delete pod <name>`), or simulate network failure (e.g., `kubectl exec … iptables`).
2. **Self-Healing**
    - Show the orchestration platform restarting pods (check `kubectl get pods` or Swarm tasks).
3. **Operator Response**
    - Document any manual steps you would take (e.g., check logs, scale replicas, rotate a certificate).

**Deliverables:**
- Short video (≤3 min) demonstrating pod failure, recovery, and your troubleshooting steps

---

## What to Submit

- **Screenshots**: centralized log view, Grafana panels, scaling commands/results
- **Manifests/Configs**: HPA, NetworkPolicies, Secret definitions, TLS snippets
- **Video**: externally hosted resilience drill showing failure, recovery, and operator notes; submit its link as described in the [assignment submission instructions](../README.md#submission-instructions)
- **README.md**: updated with observability setup, scaling instructions, security and resilience details
- **REST Evidence**: endpoint request/response plus relevant logs, metrics, and failure-recovery behavior
- **Integrity Packet**: claims, evidence, assumptions, AI critique, and open risks

---
---  

## How You Will Be Graded

- **Observability & Logging** (20%)
  Quality of centralized log collection, metric instrumentation, dashboard clarity, and visibility into the required REST endpoint.

- **Autoscaling Configuration** (15%)
  Correct setup of HPA (or Swarm scaling) and demonstration under load/scale-down.

- **Security Hardening** (15%)
  Proper use of Secrets, NetworkPolicies (or overlay networks), and TLS enablement.

- **Resilience Drill & Recovery** (25%)  
  Effectiveness of failure injection, self-healing behavior, and documented operator actions.

- **Documentation & Usability** (10%)  
  Completeness of README, clarity of deploy/teardown commands, and ease of validation.

- **Integrity Packet (CLO7)** (15%)
  Clear operational claims, supporting metrics and logs, assumptions, failure-test validation, and documented verification of AI-assisted work.
