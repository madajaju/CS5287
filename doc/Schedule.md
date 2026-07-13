## Assignment Due Dates

| Assignment                     | Due (Friday, 11:59 PM CT) |
|--------------------------------|---------------------------|
| CA0 – Manual Deployment        |  Sep 5, 2025               |
| CA1 – Infrastructure as Code   | Sep 19, 2025              |
| CA2 – PaaS Orchestration       | Oct 17, 2025              |
| CA3 – Cloud-Native Ops         | Nov 7, 2025               |
| CA4 – Multi-Hybrid Cloud (Final)| Dec 5, 2025               |


## Weekly Learning Objectives

| Week | Objective |
| --- | --- |
| Week 0 | Establish course expectations, tooling, the integrity packet, and the shared workflow for the semester. |
| Week 1 | Build foundational understanding of cloud origins, service models, deployment choices, REST, and the integrity packet. |
| Week 2 | Connect systems, networking, security basics, and integrity-packet evidence collection to cloud behavior. |
| Week 3 | Compare virtualization and infrastructure automation approaches used to provision cloud resources. |
| Week 4 | Explain container isolation, image lifecycle, networking, and orchestration basics. |
| Week 5 | Trace how Kubernetes schedules and connects workloads, including service mesh patterns. |
| Week 6 | Apply load balancing, scheduling, and autoscaling to keep services responsive. |
| Week 7 | Analyze tail latency and use SLI, SLO, and SLA concepts to define reliable operations. |
| Week 8 | Use observability signals and chaos experiments to validate system resilience. |
| Week 9 | Distinguish serverless and edge or fog models and match them to workload patterns. |
| Week 10 | Compare distributed file systems and sharding strategies for multi-hybrid cloud storage. |
| Week 11 | Understand batch and distributed data processing frameworks and when to use them. |
| Week 12 | Evaluate GPU-based cloud execution, LLM serving, and agentic workflow patterns. |
| Week 13 | Explain SDN, NFV, and 5G integration in modern cloud networking. |
| Week 14 | Shape and present a final project plan with a clear problem, architecture, and milestones. |

## Lectures

| Week                           | Topics                                                                                                                                     |
|--------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| Week 0                         | Course Overview & Expectations, How to Use GitHub Repo & Chameleon Cloud                                                                   |
| [Week 1](Week%201/README.md)   | The Evolution of Cloud Computing, Cloud Service Models, Deployment Models, REST & RESTful APIs                                             |
| [Week 2](Week%202/README.md)   | Computer Architecture for the Cloud, Operating Systems Essentials, Networking Fundamentals, Basic Cloud Security, Message Brokers Overview |
| [Week 3](Week%203/README.md)   | Virtualization Theory, OpenStack Architecture, Infrastructure as Code Fundamentals                                                         |
| [Week 4](Week%204/README.md)   | Container Theory, Docker Fundamentals, Container Orchestration Overview                                                                    |
| [Week 5 ](Week%205/README.md)  | Kubernetes Architecture, Kubernetes Networking, Service Mesh Basics                                                                        |
| [Week 6 ](Week%206/README.md)  | Cloud Load Balancing, Kubernetes Scheduling, Scaling in Kubernetes                                                                         |
| [Week 7 ](Week%207/README.md)  | Tail Latency Problem, SRE Concepts                                                                                                         |
| [Week 8 ](Week%208/README.md)  | Observability in Cloud, Chaos Engineering                                                                                                  |
| [Week 9 ](Week%209/README.md)  | Serverless Computing, Edge & Fog Computing                                                                                                 |
| [Week 10](Week%2010/README.md) | Distributed File Systems, Data Partitioning & Sharding                                                                                     |
| [Week 11](Week%2011/README.md) | MapReduce, Apache Spark Overview, Apache Ray Overview                                                                                      |
| [Week 12](Week%2012/README.md) | GPU Architectures for Cloud, LLM Serving in the Cloud, Agentic Workflows                                                                   |
| [Week 13](Week%2013/README.md) | Software Defined Networking (SDN), Network Function Virtualization (NFV), 5G & Beyond                                                      |
| [Week 14](Week%2014/README.md) | Final Project Proposal & Presentation                                                                                                      |

### **Week 0 – Orientation**

1. **Course Overview & Expectations** – structure, grading, tools
2. **How to Use the GitHub Repo & Chameleon Cloud** – environment setup, cloning repo

---

### **Week 1 – Motivation, Models & REST**

3. **The Evolution of Cloud Computing** – history, Berkeley paper highlights
4. **Cloud Service Models (IaaS, PaaS, SaaS)** – definitions, examples
5. **Deployment Models** – public, private, hybrid, multi-cloud
6. **REST & RESTful APIs** – principles, examples, JSON over HTTP

---

### **Week 2 – Systems & Networking Refresher**

7. **Computer Architecture for the Cloud** – CPUs, memory, storage, virtualization layers
8. **Operating Systems Essentials for Cloud** – processes, scheduling, isolation
9. **Networking Fundamentals** – TCP/IP, DNS, routing basics
10. **Basic Cloud Security** – SSH, firewalls, least privilege
11. **Message Brokers Overview** – Kafka basics & use cases

---

### **Week 3 – Virtualization & IaC**

12. **Virtualization Theory** – VMs, hypervisors, paravirtualization
13. **OpenStack Architecture** – services, networking, storage in OpenStack
14. **Infrastructure as Code Fundamentals** – Terraform, Ansible, and deployment patterns

---

### **Week 4 – Containers**

15. **Container Theory** – how containers differ from VMs
16. **Docker Fundamentals** – images, containers, volumes, networking
17. **Container Orchestration Overview** – CRI-O, container runtimes

---

### **Week 5 – Kubernetes & Networking**

18. **Kubernetes Architecture** – master vs. worker nodes, API server, etcd
19. **Kubernetes Networking** – CNIs, pod networking, services
20. **Service Mesh Basics** – Istio, sidecar proxies, observability

---

### **Week 6 – Scaling & Scheduling**

21. **Cloud Load Balancing** – L4 vs L7 load balancers
22. **Kubernetes Scheduling** – pod placement, taints, tolerations, affinities
23. **Scaling in Kubernetes** – HPA, VPA, cluster autoscaler

---

### **Week 7 – Tail Latencies**

24. **Tail Latency Problem** – what it is and why it matters
25. **SRE Concepts** – SLAs, SLOs, SLIs and monitoring

---

### **Week 8 – Reliability & Chaos Engineering**

26. **Observability in Cloud** – metrics, logs, traces
27. **Chaos Engineering** – principles, tools, case studies

---

### **Week 9 – Serverless & Edge**

28. **Serverless Computing** – AWS Lambda, event-driven workloads
29. **Edge & Fog Computing** – definitions, differences, use cases

---

### **Week 10 – Cloud Storage**

30. **Distributed File Systems** – HDFS, Ceph basics
31. **Data Partitioning & Sharding** – strategies, trade-offs

---

### **Week 11 – Data Processing**

32. **MapReduce** – concepts, flow, limitations
33. **Apache Spark Overview** – RDDs, dataframes, transformations
34. **Apache Ray Overview** – parallel & distributed Python

---

### **Week 12 – AI in the Cloud**

35. **GPU Architectures for Cloud** – CUDA, tensor cores, virtualization
36. **LLM Serving in the Cloud** – deployment strategies for large models
37. **Agentic Workflows** – chaining AI tasks with orchestration tools

---

### **Week 13 – Networking Innovations**

38. **Software Defined Networking (SDN)** – control plane/data plane separation
39. **Network Function Virtualization (NFV)** – virtual appliances in cloud
40. **5G & Beyond** – edge integration with telco

---
