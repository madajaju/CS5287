# Grading Guide

This document summarizes the grading expectations for the CS5287 cloud-computing
course projects. The assignment README is authoritative if a requirement or
weight changes.

## General submission requirements

- Submit each assignment by 11:59 PM Central Time on its due date.
- Push the completed assignment to a Git repository the instructor can access.
- Put each assignment in a clearly named `CA0` through `CA4` directory on the
  `main` or `master` branch.
- Include a `README.md` in each assignment directory with links to its code and
  documentation.
- Paste the repository URL in the Brightspace submission note and verify that
  the URL opens the correct repository and branch.
- No late submissions are accepted.

CA0, CA3, and CA4 also require a demo video. Store the video in Vanderbilt-
approved cloud storage or another private/unlisted service; do not commit
video files to Git. Put the viewable URL in the assignment README and in the
Brightspace submission note. Test the link in a private browser window.

## Shared grading expectations

The logical IoT pipeline should remain consistent across the assignments:

`Producers → pub/sub hub → Processor → DB/Analytics`

The implementation must include a pub/sub hub, at least one REST endpoint, and
at least four distinct services or VMs in CA0 and CA1. Students may substitute
equivalent technologies when the required capabilities are preserved and the
choice is documented.

Every assignment must include an Integrity Packet. It should document:

- engineering or design claims;
- evidence supporting each claim;
- assumptions and known limitations;
- validation and test results; and
- AI assistance that was verified, revised, accepted, or rejected.

The Integrity Packet is worth 15% of every assignment. A missing packet earns no
credit for that criterion.

## Assignment rubrics

### CA0 — Manual Deployment

| Criterion | Weight |
|---|---:|
| Correctness and completeness | 15% |
| Security controls | 15% |
| Documentation and diagrams | 15% |
| Demo quality | 5% |
| Cloud-modality execution | 25% |
| Reproducibility and clarity | 10% |
| Integrity Packet (CLO7) | 15% |
| **Total** | **100%** |

### CA1 — Infrastructure as Code

| Criterion | Weight |
|---|---:|
| Idempotency and reproducibility | 20% |
| Security and secret management | 15% |
| Pipeline correctness | 20% |
| Documentation and ease of use | 15% |
| Cloud-modality execution | 10% |
| Automation quality | 5% |
| Integrity Packet (CLO7) | 15% |
| **Total** | **100%** |

### CA2 — PaaS Orchestration

| Criterion | Weight |
|---|---:|
| Declarative completeness | 20% |
| Security and isolation | 15% |
| Scaling and observability | 20% |
| Documentation and usability | 20% |
| Platform execution | 10% |
| Integrity Packet (CLO7) | 15% |
| **Total** | **100%** |

### CA3 — Cloud-Native Operations

| Criterion | Weight |
|---|---:|
| Observability and logging | 20% |
| Autoscaling configuration | 15% |
| Security hardening | 15% |
| Resilience drill and recovery | 25% |
| Documentation and usability | 10% |
| Integrity Packet (CLO7) | 15% |
| **Total** | **100%** |

### CA4 — Multi-Hybrid Cloud Final Project

| Criterion | Weight |
|---|---:|
| Design and architecture | 20% |
| Connectivity and security | 15% |
| Deployment automation | 15% |
| Resilience and runbooks | 25% |
| Documentation and usability | 10% |
| Integrity Packet (CLO7) | 15% |
| **Total** | **100%** |

## Due dates

| Assignment | Due |
|---|---|
| CA0 — Manual Deployment | September 4, 2026 |
| CA1 — Infrastructure as Code | September 18, 2026 |
| CA2 — PaaS Orchestration | October 16, 2026 |
| CA3 — Cloud-Native Operations | November 6, 2026 |
| CA4 — Multi-Hybrid Cloud Final | December 4, 2026 |

