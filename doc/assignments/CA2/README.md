# CA2 – PaaS Orchestration (Kubernetes or Docker Swarm)

**Goal:** Declare and run your CA0 pipeline on a container-orchestration platform, using purely declarative configuration and minimal imperative commands.

---

## Integrity Packet Requirement

Include an Integrity Packet with CA2. It should track the design claims for the orchestrated stack, the manifests and outputs that support those claims, and any AI guidance you validated before using it.

---

## What You Must Do

### Research and Preparation

The course repository provides the architectural context for this assignment, but it is not a complete implementation
guide. Before building the stack, research Kubernetes StatefulSets, PersistentVolumeClaims (PVCs), Services,
ConfigMaps, Secrets, and Role-Based Access Control (RBAC), or the equivalent Docker Swarm concepts. Use your GenAI
tools to explore these topics and troubleshoot your design, then verify the guidance against the official Kubernetes
or Docker documentation. Record consequential AI guidance, what you verified, and what you accepted or rejected in
your Integrity Packet.

1. **Platform Provisioning**
    - Stand up a Kubernetes cluster (managed or self-hosted) or a Docker Swarm with at least 3 nodes.
    - Record cluster type/version, node roles, namespaces (K8s) or overlay networks (Swarm).

2. **Container Images & Registry**
    - Use public container images or build your own (e.g., producer, Kafka, processor, database).
    - Push them to a registry you control (Docker Hub, ECR, GCR, or private).
    - Ensure manifests reference the correct registry addresses and image tags.

3. **Declarative Configuration**
    - Write Kubernetes manifests (YAML) or Swarm Compose files (v3):  
      • **Kafka**: StatefulSet (with ZooKeeper or KRaft), PVCs, Service.  
      • **DB**: StatefulSet or Service+PVC.  
      • **Processor**: Deployment, ConfigMap for settings, Secret for credentials, Service (ClusterIP).  
      • **Producers**: Deployment/Job/CronJob (for one-off replay) or Swarm “replicas” setting.
    - Define `ConfigMaps`/`Secrets` for configuration and credentials.
    - Declare and expose at least one REST endpoint for pipeline control or data retrieval.
    - Enforce network isolation:  
      • K8s `NetworkPolicy` restricting traffic between namespaces/services.  
      • Swarm overlay networks scoped to required services.

4. **Scaling Demonstration**
    - Configure Horizontal Pod Autoscaler (K8s) or use `docker service scale` (Swarm) to scale producers from 1 up to N replicas.
    - Optionally scale the processor or database tier to show elasticity.
    - Measure traffic (msgs/sec) or simple end-to-end latency before and after scaling; capture a brief chart or table.

5. **Security & Access Controls**
    - Mount secrets rather than embedding in manifests.
    - Use Role-Based Access Control (K8s) or Swarm service labels to limit access.
    - Expose only the necessary ports via Services or published ports.

6. **Validation & Teardown**
    - Provide a single command (or Makefile target) to apply the full stack and another to delete it.
    - After deployment, run a quick smoke test: send a sample event, inspect Kafka topic, observe processor logs, and verify a record in the database.
    - Include a successful request and response from the REST endpoint in the smoke-test evidence.

7. **Documentation & Deliverables**
    - **Directory Structure**: all manifests/stack files in `CA2/` with clear names.
    - **README.md** detailing:
        - Prerequisites (kubectl/docker versions, cluster context, registry creds).
        - Deploy and destroy commands.
        - How to run the scaling test and where to find logs/results.
        - Any deviations from CA0/CA1 and reasons.
    - **Integrity Packet** documenting manifest claims, test evidence, AI use, and implementation notes.
    - **Outputs**:
        - Screenshot of `kubectl get all -A` or `docker stack ps`.
        - NetworkPolicy YAML or Swarm network diagram.
        - Scaling results snapshot (chart or table).

---

## How You Will Be Graded

- **Declarative Completeness** (20%)
  All four pipeline stages and the required REST endpoint are defined and exposed purely through manifest/compose files.

- **Security & Isolation** (15%)
  Proper use of Secrets, NetworkPolicies (K8s) or overlay networks (Swarm), minimal published ports.

- **Scaling & Observability** (20%)  
  Demonstrated replica/HPA scaling with metrics or latency comparison.

- **Documentation & Usability** (20%)
  Clear README, simple deploy/destroy steps, validation instructions.

- **Platform Execution** (10%)  
  Correct use of Kubernetes or Swarm primitives, clean resource cleanup.

- **Integrity Packet (CLO7)** (15%)
  Clear manifest and scaling claims, supporting test evidence, assumptions, validation, and documented verification of AI-assisted work.

---

## Tips & Best Practices

- Organize manifests by component (e.g., `kafka/`, `db/`, `processor/`, `producer/`).
- Use labels and annotations to group and filter resources.
- Validate your YAML/Compose syntax with `kubectl apply --dry-run=client` or `docker-compose config`.
- Test destroy early to avoid ghost resources.
- Keep your README up-to-date as you iterate.  
