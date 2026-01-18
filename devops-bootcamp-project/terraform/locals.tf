locals {
  tags = {
    Project = "devops-bootcamp"
    Owner   = var.project_name
  }

  vpc_cidr            = "10.0.0.0/24"
  public_subnet_cidr  = "10.0.0.0/25"
  private_subnet_cidr = "10.0.0.128/25"
}

