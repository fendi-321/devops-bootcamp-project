resource "aws_ecr_repository" "app" {
  name                 = "${var.project_name}-${var.ecr_repository_name}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name    = "${var.project_name}-${var.ecr_repository_name}"
    Project = var.project_name
  }
}

