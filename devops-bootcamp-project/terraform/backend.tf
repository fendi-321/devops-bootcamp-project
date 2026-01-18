terraform {
  backend "s3" {
    bucket = "devops-bootcamp-terraform-maffindi"
    key    = "state/terraform.tfstate"
    region = "ap-southeast-1"
  }
}
