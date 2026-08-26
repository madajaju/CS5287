## Assignment Due Dates

| Assignment                     | Due (Friday, 11:59 PM CT) |
|--------------------------------|---------------------------|
| CA0 – Manual Deployment        | Sep 4, 2026               |
| CA1 – Infrastructure as Code   | Sep 18, 2026              |
| CA2 – PaaS Orchestration       | Oct 16, 2026              |
| CA3 – Cloud-Native Ops         | Nov 6, 2026               |
| CA4 – Multi-Hybrid Cloud (Final)| Dec 4, 2026              |

## Fall 2026 Course Calendar

Classes meet Thursdays at 5:00 PM Central Time (CT). Week 0 orientation is completed before the
first class meeting.

| Course Week | Date | Topics | Assignment Milestone |
| --- | --- | --- | --- |
| Week 0 | Before August 27 | Course introduction, repository, and environment setup | Environment setup |
| Week 1 | August 27 | Cloud computing, cloud enablers, opportunities, and REST | Assign CA0 |
| Week 2 | September 3 | Operating systems, networking, message brokers, and Kafka | Submit CA0 September 4 |
| Week 3 | September 10 | Virtualization, IaaS, OpenStack, and infrastructure as code | Assign CA1 |
| Week 4 | September 17 | Containers, container networking, Docker, and Docker Swarm | Submit CA1 September 18 |
| Week 5 | September 24 | Kubernetes architecture, networking, and service mesh | Preview CA2; on-campus convening September 25–26 |
| Week 6 | October 1 | Cloud load balancing, Kubernetes scheduling, and scaling | Start CA2 |
| Week 7 | October 8 | Observability, SRE components, and tail latency | Continue CA2 |
| Week 8 | October 15 | Chaos engineering | Submit CA2 October 16 |
| — | October 22 | **Fall break—no class** | — |
| Week 9 | October 29 | Edge computing, overlay VPN, and serverless computing | Assign CA3 |
| Week 10 | November 5 | Data partitioning and distributed file systems | Submit CA3 November 6 |
| Week 11 | November 12 | MapReduce, Apache Spark, and Apache Ray | Start CA4 |
| Week 12 | November 19 | GPU architectures, LLM serving, and agentic workflows | Continue CA4 |
| — | November 26 | **Thanksgiving break—no class** | — |
| Week 13 | December 3 | SDN, NFV, and 5G and beyond | Submit CA4 December 4 |
| Week 14 | December 10 | Individual final project demonstrations and technical defense | Present CA4 |


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
| Week 7 | Analyze tail latency and use observability signals, SLIs, SLOs, and SLAs to define reliable operations. |
| Week 8 | Apply chaos-engineering principles and experiments to validate system resilience. |
| Week 9 | Distinguish serverless and edge or fog models and match them to workload patterns. |
| Week 10 | Compare distributed file systems and sharding strategies for multi-hybrid cloud storage. |
| Week 11 | Understand batch and distributed data processing frameworks and when to use them. |
| Week 12 | Evaluate GPU-based cloud execution, LLM serving, and agentic workflow patterns. |
| Week 13 | Explain SDN, NFV, and 5G integration in modern cloud networking. |
| Week 14 | Demonstrate and defend the completed final project using architecture, operational evidence, and lessons learned. |

## Lecture Topics

| Week | Date | Topics |
| --- | --- | --- |
| Week 0 | Before August 27 | Course Overview & Expectations, GitHub Repository & Environment Setup |
| [Week 1](Week%201/README.md) | August 27 | Cloud Computing, Cloud Enablers, Obstacles and Opportunities, Topics of Study, REST |
| [Week 2](Week%202/README.md) | September 3 | Operating Systems, Processes, Memory, Internet Architecture and Networking, Message Brokers, Kafka |
| [Week 3](Week%203/README.md) | September 10 | Virtualization, IaaS, OpenStack, Infrastructure as Code, Ansible, Terraform |
| [Week 4](Week%204/README.md) | September 17 | Containers, Container Networking and Orchestration, Docker, Docker Swarm |
| [Week 5](Week%205/README.md) | September 24 | Kubernetes Architecture, Kubernetes Networking, Service Mesh Basics |
| [Week 6](Week%206/README.md) | October 1 | Cloud Load Balancing, Kubernetes Scheduling, Scaling in Kubernetes |
| [Week 7](Week%207/README.md) | October 8 | Observability in the Cloud, SRE Components, Tail Latency Problem |
| [Week 8](Week%208/README.md) | October 15 | Chaos Engineering |
| [Week 9](Week%209/README.md) | October 29 | Edge Computing, Overlay VPN, Serverless Computing |
| [Week 10](Week%2010/README.md) | November 5 | Data Partitioning & Sharding, Distributed File Systems |
| [Week 11](Week%2011/README.md) | November 12 | MapReduce, Apache Spark Overview, Apache Ray Overview |
| [Week 12](Week%2012/README.md) | November 19 | GPU Architectures for Cloud, LLM Serving in the Cloud, Agentic Workflows |
| [Week 13](Week%2013/README.md) | December 3 | Software-Defined Networking (SDN), Network Functions Virtualization (NFV), 5G and Beyond |
| [Week 14](Week%2014/README.md) | December 10 | Individual Final Project Demonstration & Technical Defense |

### **Week 0 – Orientation**

1. **Course Overview & Expectations** – structure, grading, tools
2. **How to Use the GitHub Repository** – environment setup and repository cloning

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

### **Week 7 – Observability, SRE & Tail Latency**

24. **Observability in the Cloud** – metrics, logs, traces
25. **SRE Components** – SLAs, SLOs, SLIs, monitoring, and operational practices
26. **Tail Latency Problem** – what it is and why it matters

---

### **Week 8 – Reliability & Chaos Engineering**

27. **Chaos Engineering** – principles, tools, case studies

---

### **Week 9 – Edge, Overlay VPN & Serverless**

28. **Edge Computing** – edge and fog definitions, differences, and use cases
29. **Overlay VPN** – secure connectivity across distributed environments
30. **Serverless Computing** – managed and self-hosted models, event-driven workloads

---

### **Week 10 – Cloud Storage**

31. **Data Partitioning & Sharding** – strategies, trade-offs
32. **Distributed File Systems** – HDFS, Ceph basics

---

### **Week 11 – Data Processing**

33. **MapReduce** – concepts, flow, limitations
34. **Apache Spark Overview** – RDDs, DataFrames, transformations
35. **Apache Ray Overview** – parallel & distributed Python

---

### **Week 12 – AI in the Cloud**

36. **GPU Architectures for Cloud** – CUDA, tensor cores, virtualization
37. **LLM Serving in the Cloud** – deployment strategies for large models
38. **Agentic Workflows** – chaining AI tasks with orchestration tools

---

### **Week 13 – Networking Innovations**

39. **Software-Defined Networking (SDN)** – control plane/data plane separation
40. **Network Functions Virtualization (NFV)** – virtual appliances in the cloud
41. **5G and Beyond** – edge integration with telecommunications networks

---

### **Week 14 – Individual Final Project Demonstration**

42. **System Demonstration** – end-to-end data flow, REST interface, observability, and resilience
43. **Technical Defense** – architecture decisions, evidence, trade-offs, limitations, and lessons learned

---
