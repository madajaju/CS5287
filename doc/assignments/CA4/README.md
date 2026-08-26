# CA4 – Multi-Hybrid Cloud (Final)

**Goal:** Extend your end-to-end pipeline across two or more sites/clouds, ensuring secure connectivity, seamless data flow, and resilience under failure.

## Individual Project and Deliverables

CA4 is an individual assignment. Build, document, and present your own system. There is no team presentation, formal
proposal, or separate paper. Your repository documentation, Integrity Packet, architecture diagram, runbook, and demo
constitute the written and presentation deliverables.

The reference-stack selection made at the start of CA0 serves as the project planning decision. CA4 should extend that
same stack unless you clearly document and justify a necessary change.

---

## Integrity Packet Requirement

Include an Integrity Packet with CA4. It should show the design claims for the multi-site system, the evidence from connectivity and failure tests, the assumptions you made, and any AI assistance you evaluated.

---

## 1. Choose Your Topology

Select one of the following patterns or develop your own and document your choice: It must include two more locations.

- **Edge → Cloud**  
  Producers run at the edge (laptop or local cluster); Kafka, processor, and DB in a public cloud.
- **Multi-Cloud**  
  Split components (e.g., Kafka + DB in AWS, processor + producers in GCP) and coordinate between them.
- **Multi-Cluster Kubernetes**  
  Two K8s clusters (could be different providers); use cross-cluster service mesh or VPN.

---

## 2. Establish Secure Connectivity

Implement one connectivity model and describe it clearly:

- **Site-to-site VPN**  
  Automate tunnel setup and routing between subnets.
- **Service Mesh** (e.g., Istio multi-cluster)  
  Configure mutual TLS and service discovery across clusters.
- **Bastion & SSH Tunnels**  
  Use a bastion host with port-forwarding (`ssh -L`); document port mappings and firewall rules.

**Key Deliverables:**
- Config snippets or CLI commands to establish connectivity
- Verification steps (ping, curl across sites, service mesh health)
- A documented REST endpoint for pipeline control or data retrieval, including its location, access path, and security controls

---

## 3. Deploy in Each Site

- Adapt your CA2 manifests or Swarm stacks per site/cluster.
- Ensure container images are reachable (multi-arch or mirrored registry).
- Parameterize site-specific settings (subnets, DNS names, service endpoints).
- Automate deployment with a single script or Makefile that targets both environments.

**Key Deliverables:**
- Per-site/cluster manifest directory (clear naming)
- Deployment command or script and brief instructions

---

## 4. Simulate Failure & Recover

- Choose one failure scenario (e.g., take down the Kafka site, disrupt VPN).
- Perform the drill and observe:
    1. Service unavailability or errors in the dependent site.
    2. Automated or manual recovery steps you execute.
- Document actions and results in a concise runbook section.

**Key Deliverables:**
- Short video (≤4 min) showing failure injection and recovery
- Written runbook entries for incident response

---

## 5. Documentation & Submissions

1. **Architecture Diagram**
    - Show CIDRs, gateways, VPN tunnels or mesh connections, and component placement.
2. **Runbook**
    - Steps for bring-up, tear-down, and failure recovery (include commands and troubleshooting tips).
3. **Demo Video**
    - End-to-end data flow across sites, a successful REST request and response, and the resilience drill.
    - Host the video externally and submit its link as described in the [assignment submission instructions](../README.md#submission-instructions).
4. **README.md**
    - Overview of topology, connectivity method, deployment instructions, and any deviations from CA2.
5. **Integrity Packet**
    - Claims, evidence, assumptions, AI critique, and recovery notes.

---

## How You Will Be Graded

- **Design & Architecture** (20%)
  Clarity of topology choice, diagram accuracy, and rationale.
- **Connectivity & Security** (15%)
  Proper VPN/mesh/tunnel configuration, encrypted traffic, minimal open ports, and secure reachability of the required REST endpoint.
- **Deployment Automation** (15%)
  Ease of deploy/teardown, parameterization, and use of multi-site settings.
- **Resilience & Runbooks** (25%)  
  Effectiveness of failure drill, recovery steps, and quality of runbook documentation.
- **Documentation & Usability** (10%)  
  Completeness of README, clarity of instructions, and demo video quality.
- **Integrity Packet (CLO7)** (15%)
  Clear multi-site and resilience claims, supporting evidence, assumptions, recovery validation, and documented verification of AI-assisted work.
