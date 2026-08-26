# Edge Computing and Cloud Architecture

Video: https://youtu.be/TghbRaf2fHQ

## 1. Introduction

### 1.1 Definitions
- **Cloud Computing**
    - On-demand provision of scalable compute, storage, networking
    - Delivered by third-party providers via internet
    - Abstracts physical infrastructure from developers and users
- **Edge Computing**
    - Decentralized extension of cloud capabilities to the network edge
    - Processing conducted close to data source (sensors, devices)
    - Aims to minimize latency, save bandwidth, and improve reliability

### 1.2 Motivation for Hybrid Architectures
- Explosive growth of IoT devices
- Real-time analytics requirements (smart manufacturing, AR/VR)
- Geopolitical and regulatory constraints on data movement
- Cost optimization by filtering data before long-haul transfer

**Discussion Prompt:**  
“Identify an application in your daily life that could benefit from edge processing rather than pure cloud.”

---

## 2. Cloud Architecture Overview

### 2.1 Architectural Layers (with Responsibilities)
- **Physical Layer**
    - Data center facilities, power, cooling, racks, NICs, fiber
- **Virtualization Layer**
    - Hypervisors (Xen, KVM), Container Engines (Docker)
    - Resource partitioning and multi-tenancy enforcement
- **Management & Orchestration**
    - Tools: Kubernetes, OpenStack, VMware vSphere
    - Scheduling, lifecycle management, health checking
- **Middleware & Platform Services**
    - Databases (SQL, NoSQL), message buses (Kafka, RabbitMQ)
    - Identity & Access (OAuth, IAM), monitoring (Prometheus)
- **Application Layer**
    - Microservices, serverless functions, web/mobile frontends

### 2.2 Key Benefits
- **Elasticity**: Automatic scaling up/down based on demand metrics
- **Global Distribution**: Multiple Availability Zones (AZs), Regions
- **Managed Services**: Databases, ML APIs, content delivery, identity
- **Cost Efficiency**: Pay only for actual usage; reserved/spot pricing

### 2.3 Common Challenges
- **Latency & User Experience**
    - 100 ms+ network round-trip can degrade real-time applications
- **Egress Costs**
    - Large data sets exported from cloud incur bandwidth charges
- **Outages & Failures**
    - Zone or region failures require multi-region design
- **Compliance**
    - GDPR, HIPAA, data residency regulations

---

## 3. Edge Computing Overview

### 3.1 Core Drivers
- **Ultra-Low Latency**: Sub-10 ms responses for robotics, AR/VR
- **Bandwidth Savings**: Preprocessing (e.g., video compression, anomaly detection)
- **Disconnected Operation**: Edge nodes operate offline, sync later
- **Data Privacy**: Sensitive information processed locally

### 3.2 Types of Edge Nodes
- **Device Edge**:
    - Smartphones (on-device ML), cameras (object detection), wearables
- **Local Edge**:
    - Industrial gateways, on-premises servers, network-attached edge appliances
- **Regional Edge**:
    - Micro-data centers at telco Points-of-Presence (PoPs) for 5G
- **Cloud Edge Services**:
    - AWS Wavelength, Azure Edge Zones, Google Distributed Cloud

### 3.3 Reference Architecture
- **Edge Agent**
    - Lightweight runtime, monitors resource usage, reports health
- **Workload Manager**
    - Deploys containerized functions, enforces policies
- **Data Plane**
    - Local storage, streaming pipelines (e.g., edge-optimized Kafka)
- **Control Plane**
    - Centralized orchestrator in cloud, for versioning & policy decisions

### 3.4 Security Considerations
- Device identity via TPM / Secure Element
- Mutual TLS for service-to-service communication
- Local encryption of persistent data
- Secure boot and firmware integrity checks

---

## 4. Cloud-to-Edge Continuum

### 4.1 Continuum Layers & Functions
- **Cloud Core**
    - Batch analytics, long-term archives, global traffic routing
- **Fog / Regional Edge**
    - Aggregation points, regional caching, ML inference close to users
- **Local Edge**
    - True real-time control, data filtering, protocol translation
- **Device**
    - Fastest response loops (control systems, AR rendering), direct user interface

### 4.2 Integration Patterns
- **Hierarchical Data Flow**: Raw data → Edge filter → Regional aggregator → Cloud store
- **Function Offloading**: ML training in cloud; inference at edge
- **Event-Driven Messaging**: MQTT, AMQP for device-to-edge; HTTPS/gRPC for edge-to-cloud

---

## 5. Use Cases (Detailed)

### 5.1 AR/VR
- Latency < 20 ms needed for comfortable experience
- Edge GPU servers perform real-time rendering; cloud pushes environment updates

### 5.2 Healthcare Monitoring
- Wearables analyze ECG, glucose levels locally
- Alerts generated on device; anonymized data sent to cloud for population analytics

### 5.3 Retail & Smart Buildings
- Cameras detect occupancy and foot traffic—edge ML reduces false positives
- Cloud dashboards aggregate chain-wide metrics

### 5.4 Autonomous Vehicles
- In-vehicle compute for perception & control loops
- Edge nodes at cell towers support cooperative awareness
- Cloud consolidates telemetry for fleet management

---

## 6. Challenges & Best Practices

### 6.1 Resource Constraints
- Optimize ML models (quantization, pruning)
- Use minimal base OS images (Distroless, Alpine)

### 6.2 Deployment & Management
- GitOps for edge configs (Flux, Argo CD)
- Canary & blue/green rollouts at edge

### 6.3 Security & Compliance
- Implement hardware root of trust
- Centralized policy engine (OPA, Istio) with local enforcement

### 6.4 Interoperability
- Adopt open standards (OPC UA for industrial, LwM2M for IoT)
- Use protocol bridges in gateways

**Checklist:**
- “Have you defined data retention policies per node?”
- “Are your OTA updates atomic and rollback-capable?”

---

## 7. Future Trends & Research Directions

- **TinyML Frameworks**: TensorFlow Lite, Edge Impulse
- **5G Standalone & Network Slicing**: Dedicated slices for critical edge workloads
- **Serverless at Edge**: Function runtimes deployed within CDN PoPs
- **Federated Learning**: Collaborative ML across distributed nodes without raw data exchange
- **Edge AI Hardware**: NVIDIA Jetson, Google Coral, Intel Movidius

**Research Prompt:**  
“Explore the trade-offs of federated learning vs. centralized model training in an edge ecosystem.”

---

## 8. Conclusion & Next Steps

- **Recap**
    - Cloud provides scale, edge provides responsiveness
    - Hybrid architectures balance performance, cost, and compliance
- **Action Items for Students**
    1. Select a real-world problem & propose a cloud-edge solution topology
    2. Identify security threats at each layer and mitigation strategies
    3. Prototype a simple edge function (e.g., image classification on Raspberry Pi)
