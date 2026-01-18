output "vpc_id" {
  value = aws_vpc.devops_vpc.id
}

output "web_eip" {
  value = aws_eip.web_eip.public_ip
}

output "web_private_ip" {
  value = aws_instance.web.private_ip
}

output "controller_private_ip" {
  value = aws_instance.controller.private_ip
}

output "monitoring_private_ip" {
  value = aws_instance.monitoring.private_ip
}

output "ecr_repository_url" {
  description = "URL of the ECR repository for the application."
  value       = aws_ecr_repository.app.repository_url
}

output "ecr_repository_name" {
  description = "Name of the ECR repository for the application."
  value       = aws_ecr_repository.app.name
}
