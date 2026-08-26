# Kubernetes Architecture Primer

Kubernetes is a container orchestration platform that
automates deployment, scaling, and management of containerized applications. Its architecture separates control-plane components from data-plane (worker node) components.

---

## High-Level Components

![KubernetesArchitectureDiagram.png](KubernetesArchitectureDiagram.png)

### Control Plane (Master)
- **kube-apiserver**  
  Central REST API; all clients (kubectl, nodes, controllers) communicate here.
- **etcd**  
  Distributed key-value store for cluster state and configuration.
- **kube-scheduler**  
  Assigns newly created Pods to available nodes based on resource requirements, affinities, and policies.
- **kube-controller-manager**  
  Runs controllers that reconcile actual state with desired state (e.g., ReplicaSet, Deployment, Node, Endpoint).
- **cloud-controller-manager** (optional)  
  Integrates with cloud provider APIs to manage load balancers, volumes, and node lifecycle.

### Worker Nodes (Data Plane)
- **kubelet**  
  Agent that watches for Pod specs from the API server, ensures containers are running, and reports status.
- **kube-proxy**  
  Implements Service forwarding & load-balancing at the node level (via iptables, IPVS, or userspace).
- **Container Runtime**  
  Runs containers (Docker, containerd, CRI-O).

---

## Control Plane Workflow

1. **User Action**  
   `kubectl apply -f deployment.yaml` → API call to kube-apiserver.
2. **Persistence**  
   API server writes desired state to etcd.
3. **Scheduling**  
   Scheduler watches for unscheduled Pods, picks a node, and updates Pod spec.
4. **Reconciliation**  
   Controller-manager observes actual state vs. desired; creates or deletes ReplicaSets, Pods, Services, and other resources to converge state.

![KubernetesControlPlaneWorkflow.png](KubernetesControlPlaneWorkflow.png)

---

## Worker Node Workflow

1. **Pod Assignment**  
   Kubelet polls API server for Pods assigned to its node.
2. **Pod Lifecycle**  
   Kubelet pulls images, creates containers via the container runtime, and starts them.
3. **Health & Status**  
   Liveness/readiness probes defined in Pod specs are executed by kubelet. Status is updated back to the API server.
4. **Service Networking**  
   Kube-proxy watches Service and Endpoint objects; programs forwarding rules on the node so Pods can reach Services via ClusterIP, NodePort, or load-balanced VIPs.

![WorkerNodeWorkflowSequence-Worker_Node_Workflow_Sequence.png](WorkerNodeWorkflowSequence-Worker_Node_Workflow_Sequence.png)

---

## Key Objects & Concepts

- **Pod**  
  Smallest deployable unit: one or more tightly coupled containers sharing network namespace and volumes.
- **Service**  
  Stable virtual IP (ClusterIP), DNS name, and load-balancing for a set of Pods.
- **Deployment**  
  Declarative rollout, update, and rollback of ReplicaSets.
- **ConfigMap & Secret**  
  Inject configuration data and sensitive credentials into Pods.
- **Namespace**  
  Virtual cluster partition within one Kubernetes installation; isolates resources per team or environment.
- **Admission Controller**  
  Pluggable policy enforcement on requests to the API server (e.g., resource quotas, pod security policies).

![KubernetesDeploymentComponentsDiagram.png](KubernetesDeploymentComponentsDiagram.png)

---

## Networking Model

- **Flat, Pod-to-Pod**  
  Every Pod gets a unique IP; all Pods can communicate without NAT.
- **CNI Plugins**  
  Implement network model (Calico, Flannel, Weave, Cilium).
- **Service IPs & Load Balancing**  
  kube-proxy implements Service VIPs; external load balancers can integrate via cloud-controller-manager.

---

## High Availability & Scaling

- **HA Control Plane**  
  Run multiple replicas of API server, scheduler, and controller-manager; etcd in clustered mode.
- **Horizontal Scaling**  
  Add worker nodes to scale capacity; kube-scheduler distributes Pods.
- **Cluster Federation (Optional)**  
  Manage multiple clusters across regions or clouds with a single control plane.

---

## Observability & Security

- **Metrics & Logs**  
  Expose metrics from components (Prometheus); collect container logs (EFK/Loki).
- **RBAC**  
  Role-based access control for API operations.
- **NetworkPolicies**  
  Define allowed Pod-to-Pod traffic via CNI or eBPF.
- **TLS Everywhere**  
  Secure API server, kubelet, etcd, and inter-component communication.

---

# Summary

Kubernetes architecture decouples control and data planes via well-defined components and APIs, enabling declarative management of containerized workloads at scale. Understanding each component’s role—API server, etcd, scheduler, controllers, kubelet, and networking—is essential for deploying and operating production-grade clusters.