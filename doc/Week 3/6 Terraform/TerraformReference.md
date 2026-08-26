# Terraform Reference Guide

A quick-reference for common Terraform concepts, configuration patterns, and CLI commands.

---

## 1. Files & Structure

├── main.tf          # core configuration (providers, resources)  
├── variables.tf     # `variable` blocks & defaults  
├── outputs.tf       # `output` blocks  
├── terraform.tfvars # variable values (git-ignored)  
├── modules/         # reusable module folders  
│   └── my-module/   # e.g., modules/my-module/{main.tf,variables.tf,outputs.tf}  
├── backend.tf       # backend configuration (remote state)  
└── versions.tf      # required Terraform & provider versions  

---

## 2. Configuration Language (HCL)

### Provider
```hcl

terraform {
    required_version = ">= 1.5.0"
    required_providers {
        aws = { source = "hashicorp/aws", version = "~> 5.0" }
    }
    backend "s3" {
        bucket = "tf-state-bucket"
        key    = "project/terraform.tfstate"
        region = "us-west-2"
    }
}

provider "aws" {
region = var.aws_region
}
```
### Resource
```hcl
resource "aws_instance" "web" {
    ami           = var.ami_id
    instance_type = var.instance_type
    tags = { Name = "web-${terraform.workspace}" }
}
```
### Variable
```hcl
variable "aws_region" {
    description = "AWS region"
    type        = string
    default     = "us-west-2"
}

variable "instance_type" {
    description = "EC2 instance size"
    type        = string
    default     = "t3.micro"
}
```
### Output
```hcl
    output "public_ip" {
    description = "Web server public IP"
    value       = aws_instance.web.public_ip
}
```
---

## 3. Modules

Call a module:
```hcl
module "network" {
source      = "./modules/network"
cidr_block  = "10.0.0.0/16"
azs         = ["us-west-2a","us-west-2b"]
}
```
Module folder (`modules/network`):

- `main.tf` — resources  
- `variables.tf` — module inputs  
- `outputs.tf` — module outputs  

---

## 4. State & Backends

- **Local** (default): `terraform.tfstate` in working directory  
- **Remote**: configure backend in `terraform { backend "s3" { … } }`  
  - Enables state locking, versioning, team workflows  

Switch workspace:
```bash
terraform workspace new staging
terraform workspace select production
```
---

## 5. Common CLI Commands

Initialize directory (download providers/modules):
```bash
terraform init
```
Preview changes:
```bash
terraform plan \
-var="aws_region=us-east-1" \
-out=plan.tfplan
```
Apply changes:
```bash

terraform apply plan.tfplan
# or
terraform apply -auto-approve
```
Show current state:
```bash
terraform show
```
Refresh state (update from real infra):
```bash

terraform refresh
```
Destroy resources:
```bash

terraform destroy -auto-approve
```
Validate config syntax:
```bash

terraform validate
```
Format files:
```bash

terraform fmt
```
Graph resource dependencies:
```bash

terraform graph | dot -Tpng > graph.png
```
---

## 6. Tips & Best Practices

- **Version Pinning**: specify `required_version` and provider versions.  
- **.gitignore**: exclude `*.tfstate`, `*.tfvars`, `.terraform/`.  
- **Secrets**: never commit secrets—use Vault, environment variables, or encrypted tfvars.  
- **DRY**: refactor repetitive code into modules.  
- **Review**: always run `terraform plan` and inspect diffs before `apply`.  
- **Locking**: use remote backends (S3+DynamoDB, Azure Storage, etc.) for locking.  
- **State Management**: prune unused resources via `terraform state rm`.  
- **CI/CD**: integrate Terraform Cloud or GitHub Actions for automated plans & applies.  

---

## 7. Further Reading

- Terraform Documentation: https://www.terraform.io/docs  
- Terraform Registry (modules & providers): https://registry.terraform.io  
- “Terraform Up & Running” by Yevgeniy Brikman  
- HashiCorp Learn tutorials: https://learn.hashicorp.com/terraform
