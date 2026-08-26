# CA1 – Infrastructure as Code (IaC)

**Goal:** Implement your CA0 manual deployment entirely via code—spinning up VMs, installing services, wiring the pipeline, and tearing everything down—with minimal manual steps.

---

## Integrity Packet Requirement

Include an Integrity Packet with CA1. Capture the claims your automation makes, the evidence that proves the deployed state, the assumptions in your code, and any AI-assisted work you reviewed or revised.

---

## What You Must Do

1. **Choose Your IaC Tooling**  
   Select one or combine: Ansible, Terraform (plus Ansible), Puppet, Chef, CloudFormation, ARM/Bicep, etc.

2. **Idempotent Provisioning**
    - Define VM instances (count, size, region) in code.
    - Declare network/subnet, security groups/firewall rules.
    - Install your reference-stack components (for example, your selected pub/sub hub, database, processor, and producers).
    - Ensure repeated runs do not produce drift.

3. **Parameterization & Flexibility**
    - Expose variables for region, VM sizes, image tags, topic names, credentials.
    - Provide sensible defaults and allow overrides via CLI flags or variable files.

4. **Secure Secret Handling**
    - Integrate a vault or cloud secret manager (HashiCorp Vault, AWS Secrets Manager, Azure Key Vault, etc.).
    - Do **not** check plaintext passwords, tokens, or keys into your repository.

5. **Automated Deployment & Teardown**
    - Create simple commands (or scripts) to deploy **and** destroy the entire environment.
    - Verify that “destroy” cleans up all resources your code created.

6. **Pipeline Validation**
    - After deployment, run a smoke test:
        1. Produce a sample event.
        2. Observe Kafka topic ingestion.
        3. Verify the processor container consumes and writes to the database.
        4. Send a request to the required REST endpoint and verify its response.
    - Capture logs or screenshots of each stage.
    - Provision and configure the REST interface through code; it must not depend on undocumented manual setup.

7. **Documentation & Deliverables**
    - **Repository**: Include all IaC code and a top-level `README.md`.
    - **README.md** should describe:
        - Prerequisites (CLI versions, credentials setup).
        - How to deploy (one or two commands).
        - How to destroy.
        - How to run validation tests.
        - Any deviations from CA0 or your reference stack.
    - **Integrity Packet** showing the reasoning, evidence, and AI critique for the automated deployment.
    - **Run Logs**: Attach logs or console output showing successful create/destroy and pipeline test.
    - **Outputs Summary**: List endpoints/IPs, topic names, database connection strings, and validation results.

---

## How You Will Be Graded

- **Idempotency & Reproducibility** (20%)
  Deployment can be run multiple times with consistent results; destroy leaves no remnants.
- **Security & Secret Management** (15%)  
  No secrets in code; use a vault or secret manager properly.
- **Pipeline Correctness** (20%)  
  Kafka broker, processor, producers, DB, and the required REST endpoint are deployed and correctly wired with smoke-test proof.
- **Documentation & Ease of Use** (15%)
  Clear README, parameter descriptions, and simple deploy/destroy instructions.
- **Cloud-Modality Execution** (10%)  
  Proper use of provider-specific features (modules, providers, resource types).
- **Automation Quality** (5%)  
  Code readability, modularity, and appropriate abstraction of variables.
- **Integrity Packet (CLO7)** (15%)
  Clear automation claims, supporting run evidence, assumptions, validation, and documented verification of AI-assisted work.

---

## Tips & Best Practices

- Modularize your code (e.g., separate networking, compute, and application modules).
- Use version control branches or tags to capture “before” and “after” states.
- Validate your IaC with linting or dry-run features (`terraform plan`, `ansible --check`, etc.).
- Store secrets in a dedicated workspace or encrypted file—not in plain text.
- Test destroy workflows early to avoid lingering cloud charges.
- Keep your README up-to-date as you iterate on your code.
