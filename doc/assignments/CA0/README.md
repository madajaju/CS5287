# CA0 – Manual Deployment (Any Cloud)

**Goal:** Build and verify the full IoT pipeline “by hand” on 3–4 VMs so you understand each component end-to-end. You will provision servers, install services, wire the data flows, enforce basic security, and document everything.

---

## Integrity Packet Requirement

Include an Integrity Packet with CA0. It should capture the claim you are making about your deployment, the evidence that supports it, the assumptions behind your setup, and any AI-generated guidance you verified or rejected.

---

## Recommended Reading

The following Week 2 resources are companion guides for the pub/sub portion of CA0:

- [Message Brokers Overview](../../Week%202/8%20Message%20Brokers/README.adoc)
- [Apache Kafka Primer](../../Week%202/9%20Kafka/README.md)

Read both before selecting or configuring the pipeline's pub/sub hub. If you choose a Kafka alternative, use the
messaging patterns in these guides to evaluate and document the equivalent behavior.

---

## What You Must Do

0. **Document your software stack**
    - Choose a reference stack (e.g., Kafka, MongoDB, Docker, Kubernetes, etc.).
    - Document the components and versions you will use.
    - This reference stack will be the one you use through the course. It is your choice. Choose wisely.

1. **Environment Provisioning**
    - Choose a cloud provider or an on-premises environment (for example, AWS, Azure, or GCP).
    - Create 3–4 VMs (≈2 vCPU, 4 GB RAM each), noting region, machine type, network/subnet.
    - **Record** VM names, IPs, and any provider defaults.

2. **Software Installation & Configuration**
    - Install a Pub/Sub hub (Kafka broker + ZooKeeper or equivalent).
    - Deploy your DB (MongoDB or CouchDB).
    - Launch a Processor container (e.g., inference or transform service).
    - Run 1–2 Producer containers (data simulator or replay image).
    - Ensure each service starts on boot and logs to a known location.

3. **Data Pipeline Wiring**
    - Create topics/queues, configure producer → broker → processor → DB flow.
    - Push sample messages and verify they appear in the database.
    - Capture at least one end-to-end test log or screenshot of successful records.
    - Expose at least one documented REST endpoint for pipeline control or data retrieval.
    - Demonstrate a successful request and response from the REST endpoint.

4. **Security Hardening**
    - Disable password login; enforce SSH key authentication only.
    - Restrict inbound firewall rules to only essential ports (e.g., 22, 9092, 27017).
    - Run containers as non-root users where supported.

5. **Documentation & Deliverables**
    - **README.md** in your `CA0/` folder listing:
        - VM specs (size, OS, IPs), image tags, and version numbers.
        - High-level steps executed (you may capture commands or UI screenshots).
        - Any deviations from the reference stack and the reason why.
    - **Integrity Packet** documenting claims, evidence, assumptions, AI assistance, and validation results.
    - **Network Diagram** showing subnets/CIDRs, open ports, and trust boundaries.
    - **Configuration Summary** table: component name, image/version, host, port.
    - **Demo Video** (1–2 minutes): recording of you running the producer, observing Kafka and the processor, and verifying a database entry. Host the video externally and submit its link as described in the [assignment submission instructions](../README.md#submission-instructions).
    - **Screenshots** of critical milestones (VM creation, service status, security settings).

---

## How You Will Be Graded

- **Correctness & Completeness** (15%): all four pipeline stages and the required REST endpoint are installed, wired, documented, and verified.
- **Security Controls** (15%): SSH key only, minimal open ports, non-root containers.
- **Documentation & Diagrams** (15%): clear README, up-to-date network diagram, config table.
- **Demo Quality** (5%): concise, shows full data flow.
- **Cloud-Modality Execution** (25%): proper use of chosen provider’s console or CLI.
- **Reproducibility & Clarity** (10%): another student could follow your README to rebuild.
- **Integrity Packet (CLO7)** (15%): clear claims, evidence, assumptions, validation results, and documented verification of AI-assisted work.

---

## Tips & Best Practices

- Plan your network layout before VM creation.
- Automate repetitive steps in a simple script or note them clearly.
- Take screenshots as you go—don’t rely on memory.
- If you hit a version or compatibility issue, document the problem and your workaround.
- Keep your README self-contained; avoid external links that may break over time.
