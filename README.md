# devops-bootcamp-project

This repository contains **Terraform** (infrastructure) and **Ansible** (configuration) for the DevOps Bootcamp final project.

## Structure

```
devops-bootcamp-project/
├── terraform/
├── ansible/
└── README.md
```

## Quick validation (no apply)

### Terraform

```bash
cd terraform
terraform fmt -check -recursive
terraform init
terraform validate
terraform plan -refresh=false
```

> Note: `terraform plan` requires AWS credentials because it resolves the Ubuntu 24.04 AMI from AWS.

### Ansible

```bash
cd ansible
ansible-playbook --syntax-check -i inventories/production/hosts.ini playbooks/site.yml
```

## Required updates before real deployment

* Configure Terraform remote state by copying `terraform/backend.s3.tf.example` to `terraform/backend.tf` and updating the bucket name (must be globally unique).
* Ensure you have AWS credentials configured locally (`aws configure` or environment variables).
* Provide SSH access (optional) and/or use SSM for access.
* Update `ansible/inventories/production/hosts.ini` with the correct hosts (EIP for web; private IPs for controller/monitoring).
