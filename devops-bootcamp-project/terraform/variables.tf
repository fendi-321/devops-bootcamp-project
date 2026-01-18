variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "project_name" {
  description = "Name prefix for resources"
  type        = string
  default     = "devops"
}

variable "ecr_repository_name" {
  description = "ECR repository name suffix (will be prefixed with project_name)."
  type        = string
  default     = "my-devops-project"
}

variable "admin_cidr" {
  description = "CIDR allowed to SSH to the public web server (change to your public IP /32)."
  type        = string
  default     = "0.0.0.0/0"
}

variable "ssh_key_name" {
  description = "Optional EC2 key pair name for SSH access. Leave null to rely on SSM."
  type        = string
  default     = null
}
