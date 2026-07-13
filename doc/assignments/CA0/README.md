# CA0 – Manual Deployment (Any Cloud)

**Goal:** Build and verify the full IoT pipeline “by hand” on 3–4 VMs so you understand each component end-to-end. You will provision servers, install services, wire the data flows, enforce basic security, and document everything.

---

## Integrity Packet Requirement

Include an Integrity Packet with CA0. It should capture the claim you are making about your deployment, the evidence that supports it, the assumptions behind your setup, and any AI-generated guidance you verified or rejected.

---

## What You Must Do

0. **Document your software stack**
    - Choose a reference stack (e.g., Kafka, MongoDB, Docker, Kubernetes, etc.).
    - Document the components and versions you will use.
    - This reference stack will be the one you use through the course. It is your choice. Choose wisely.

1. **Environment Provisioning**
    - Choose a cloud provider (Chameleon, AWS, Azure, GCP, on-prem).
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
    - **Demo Video** (1–2 minutes): recording of you running the producer, observing Kafka, processor, and verifying a DB entry.
    - **Screenshots** of critical milestones (VM creation, service status, security settings).

---

## How You Will Be Graded

- **Correctness & Completeness** (15%): all four pipeline stages installed, wired, and verified.
- **Security Controls** (15%): SSH key only, minimal open ports, non-root containers.
- **Documentation & Diagrams** (30%): clear README, up-to-date network diagram, config table.
- **Demo Quality** (5%): concise, shows full data flow.
- **Cloud-Modality Execution** (25%): proper use of chosen provider’s console or CLI.
- **Reproducibility & Clarity** (10%): another student could follow your README to rebuild.

---

## Tips & Best Practices

- Plan your network layout before VM creation.
- Automate repetitive steps in a simple script or note them clearly.
- Take screenshots as you go—don’t rely on memory.
- If you hit a version or compatibility issue, document the problem and your workaround.
- Keep your README self-contained; avoid external links that may break over time.
