# Getting Started with Terraform in IntelliJ IDEA

This guide shows you how to install and configure the Terraform plugin in IntelliJ IDEA, create a simple Terraform project, and run basic Terraform commands from within the IDE.

---

## Prerequisites

- IntelliJ IDEA (Community or Ultimate) installed  
- Terraform CLI installed and on your `PATH`  
  Verify with:
  ```bash
  terraform version
  ```
- A valid cloud provider account (AWS, Azure, GCP, etc.) and credentials configured locally (e.g., `~/.aws/credentials`, `az login`, or `gcloud auth login`).

---
## 0. Install Terraform on Your Machine

### Windows Manual Download & Install
1. Go to the Terraform downloads page:
   [https://www.terraform.io/downloads](https://www.terraform.io/downloads)
2. Under “Windows (64-bit)”, click the ZIP link to download `terraform_<version>_windows_amd64.zip`.
3. Unzip the archive to a folder of your choice, e.g.:
   `C:\tools\terraform\`
4. Add the folder to your PATH:
    - Open **Start → Settings → System → About → Advanced system settings**
    - Click **Environment Variables…**
    - Under **User variables**, select **Path → Edit → New** and enter:
      `C:\tools\terraform\`
    - Click **OK** to save.

5. Open a new PowerShell or CMD window and verify:
```bash
   terraform version
```
### MacOC Download and Install - Homebrew (Recommended)
If you use Homebrew, the HashiCorp “tap” makes it trivial:
``` bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```
- To upgrade later:
``` bash
  brew update
  brew upgrade hashicorp/tap/terraform
```
- Verify installation:
``` bash
  terraform version
```

---

## 1. Install the Terraform & HCL Plugin

1. Open IntelliJ IDEA.
2. Go to **File → Settings** (Windows/Linux) or **IntelliJ IDEA → Preferences** (macOS).
3. Select **Plugins** in the left pane.
4. Click the **Marketplace** tab and search for **Terraform and HCL**.
5. Click **Install** next to the Terraform plugin by JetBrains.
6. Restart the IDE when prompted.

---

## 2. Create a New Terraform Project

1. In IntelliJ IDEA, select **File → New → Project**.
2. Choose **Empty Project**, pick a directory, and click **Create**.
3. In the Project tool window, right-click the project root and select **New → Directory**. Name it `terraform`.
4. Right-click the `terraform` directory and select **New → File**. Name it `main.tf`.

---

## 3. Write Your First Terraform Configuration

In `main.tf`, add:
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

resource "aws_s3_bucket" "example" {
  bucket = "intellij-terraform-example-${random_id.suffix.hex}"
  acl    = "private"
}

resource "random_id" "suffix" {
  byte_length = 4
}
```
---

## 4. Enable Code Assistance

- **Syntax Highlighting & Completion**  
  Open `main.tf`. IntelliJ will now colorize HCL syntax and offer completions for resources, arguments, and interpolations.
- **Structure View**  
  Press **Alt+7** (Windows/Linux) or **⌘+7** (macOS) to open the HCL structure panel.
- **Inspections & Quick-Fixes**  
  Hover underlined text or press **Alt+Enter** to see validation errors and suggested fixes.

---

## 5. Configure Terraform Run Configurations

1. Open **Run → Edit Configurations...**
2. Click **+** and choose **Terraform** → **Terraform Init**.
    - **Working Directory**: ProjectRoot/terraform
3. Repeat to add **Terraform Plan**, **Terraform Apply**, and **Terraform Destroy** configurations.
    - For **Plan** and **Apply**, you can pass additional flags such as `-var-file=terraform.tfvars` or `-auto-approve`.

---

## 6. Run Terraform Commands

- Select **Terraform Init** and click the **Run** ▶️ button.
- After initialization completes, select **Terraform Plan** and run it to preview changes.
- Finally, run **Terraform Apply** to create resources in your cloud account.

Logs and output appear in the **Run** tool window. You can re-run, stop, or rerun with different configurations.

---

## 7. Managing State & Variables

- **`terraform.tfstate`**  
  Stored by default in the working directory. For teams, configure a remote backend (e.g., S3, GCS) in `backend "s3" { ... }` within `main.tf`.
- **`.tfvars` Files**  
  Create `terraform.tfvars` to set variable values:
  ```hcl
  aws_region = "us-east-1"
  ```
  Then add `-var-file=terraform.tfvars` to your **Plan** and **Apply** run configurations.

---

## 8. Tips & Best Practices

- Add `*.tfstate`, `.terraform/`, and `*.tfvars` to `.gitignore`.
- Use **Modules** to organize reusable code in `modules/`.
- Regularly run **terraform fmt** and **terraform validate** (IntelliJ can auto-run on save with a File Watcher).
- Integrate Terraform commands into your CI/CD pipelines via IntelliJ’s built-in terminal or external scripts.

---

Congratulations! You’re now set up to develop, plan, and apply Terraform configurations entirely within IntelliJ IDEA.
