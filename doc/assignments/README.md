# Cloud Computing Course Projects (CA0–CA4)

This course walks you through the same IoT data pipeline across five cloud modalities:

## Reference stack options and documentation requirements

The core IoT pipeline—**Producers → Kafka Pub/Sub hub → Processor → DB/Analytics**—should remain stable from CA0 through CA4 so that we can focus on learning cloud modalities rather than reinventing the software stack. Nevertheless, you must:

- Document your **starting point**: list exact container images, versions, VM sizes, network settings, and any configuration files.
- Note **every change** you introduce in subsequent assignments (e.g., updated image tags, different cloud-provider defaults, or new security group rules).
- Explain **why** a change was necessary (platform update, performance tuning, security hardening, etc.).

Students may elect to use an alternative but equivalent stack (for example, RabbitMQ instead of Kafka or PostgreSQL instead of MongoDB). Any variation **must** still satisfy:

1. A **pub/sub hub** for event delivery (e.g., Kafka, RabbitMQ, Google Pub/Sub).
2. A **REST interface** (at least one endpoint) for control or data retrieval.
3. A minimum of **four distinct services or VMs** in both CA0 and CA1—for example:
    - Producer (simulator or replay image)
    - Broker (Kafka cluster node)
    - Processor (inference, transform, or filter service)
    - Database (MongoDB, CouchDB, etc.)

Selecting and documenting this reference stack is the planning decision for the semester project. There is no separate
formal proposal assignment. Each student completes CA0–CA4 individually and evolves the selected stack across the five
assignments.

### Example Reference Stack

- **Producers**: `public-ehr-generator:latest` (simulates IoT data)
- **Kafka**: `bitnami/kafka:3.5.0` running on a dedicated VM
- **Processor**: `tensorflow/serving:2.12.0` container performing lightweight inference
- **DB/Analytics**: `mongo:6.0.4` with a second VM for monitoring dashboards

## Roadmap

- **[CA0 – Manual Deployment](CA0/README.md)**
  Any cloud provider, manual VM setup. Learn the parts end-to-end.

- **[CA1 – Infrastructure as Code (IaC)](CA1/README.md)**
  Recreate CA0 using automation (Ansible/Terraform/Puppet/Chef/etc.).

- **[CA2 – PaaS Orchestration](CA2/README.md)**
  Run the pipeline on Kubernetes **or** Docker Swarm using declarative manifests.

- **[CA3 – Cloud-Native Ops](CA3/README.md)**
  Observability (logs/metrics), autoscaling, security hardening, resilience tests.

- **[CA4 – Multi-Hybrid Cloud (Final)](CA4/README.md)**
  Distribute components across sites/clouds with secure connectivity and failover.

## Integrity Packet Requirement

Every assignment includes an Integrity Packet. Use it to document the engineering claims you are making, the evidence that supports them, the assumptions you relied on, and any AI assistance you used, verified, accepted, or rejected.

The packet is required for CA0 through CA4 and should evolve as the project grows. A starter template is available at [shared/integrity-packet-template.md](./shared/integrity-packet-template.md).

![assignments.png](assignments.png)

## Submission Instructions

Submit each assignment through its corresponding Brightspace assignment:

1. Push the completed assignment to a Git repository that the instructor can access.
2. Paste the repository URL into the **submission note** for that assignment. This is how you initially provide the
   repository to the instructor.
3. Confirm that the submitted URL opens the correct repository and branch. If the repository is private, grant the
   instructor access before the deadline.
4. Keep CA0–CA4 in clearly named directories as shown below. You may submit the same repository URL for multiple
   assignments as the repository evolves.

### Demo Video Submission

CA0, CA3, and CA4 require demo videos. Do **not** commit video files to Git.

1. Upload the video to Vanderbilt-approved cloud storage or another platform that supports private or unlisted
   sharing. Vanderbilt OneDrive with view access granted to the instructor is recommended.
2. Add the viewable video URL to the assignment's `README.md`.
3. Include the video URL in the Brightspace submission note alongside the repository URL.
4. Test the link in a private browser window before submitting. The instructor must be able to view it without
   requesting access after the deadline.
5. Use private, instructor-only, or unlisted access. Do not make course recordings public. Demo videos should show
   your system and your own presentation; do not record classmates or course sessions.

## Grading

All assignments should be submitted by the due date and must be checked into a git repository that the professor can
access. For example, if your GitHub account is "madajaju", the repository should be structured as:

```
github.com/madajaju/CS5287/
├── CA0/
│ └── README.md
├── CA1/
│ └── README.md
├── CA2/
│ └── README.md
├── CA3/
│ └── README.md
└── CA4/
└── README.md
```

Each assignment should be in its own directory on the "main" or "master" branch as shown above. The directory names must be
CA0, CA1, etc.

Each assignment should contain a README.md file that contains links to the relevant documentation and code for the
assignment. These links should reference files within the same directory structure as the README.md file.

It is your responsibility to ensure that the code is correct and that the pipeline works as expected.

I will be using Generative AI to augment my grading of the assignments. Assignments are due at 11:59 PM Central Time
on the due date. **No late submissions will be accepted.**

Each assignment has its own authoritative grading rubric in its README. Categories and weights vary according to the
skills assessed by that assignment.

Every assignment rubric reserves 15% for the Integrity Packet, which assesses CLO7. Credit is based on the quality of documented engineering claims,
supporting evidence, assumptions, validation, disclosure and verification of AI-assisted work, and ownership of the
submitted solution. A missing Integrity Packet receives no credit for this criterion.

Please ask a generative AI tool to grade your assignment against its assignment-specific rubric. I will use a similar process with my own prompts.
** I will not give you the prompts I am using. So do not ask me for them. **

## Reference stack options

- **Kafka**: `apache/kafka` or Bitnami images (KRaft ok)
- **DB**: `mongo` or `couchdb`
- **Processor**: lightweight inference demo (e.g., ResNet server image) or transform container
- **Producers**: public data-replay images or simple generator container

Keep the *same logical architecture* through CA0→CA4; change only the **cloud modality**.

## Assignment Due Dates

| Assignment                     | Assigned (Week) | Due (Friday, 11:59 PM CT) |
|--------------------------------|-----------------|---------------------------|
| CA0 – Manual Deployment        | Week 1          | Sep 4, 2026               |
| CA1 – Infrastructure as Code   | Week 3          | Sep 18, 2026              |
| CA2 – PaaS Orchestration       | Week 5          | Oct 16, 2026              |
| CA3 – Cloud-Native Ops         | Week 9          | Nov 6, 2026               |
| CA4 – Multi-Hybrid Cloud (Final)| Week 11         | Dec 4, 2026               |
