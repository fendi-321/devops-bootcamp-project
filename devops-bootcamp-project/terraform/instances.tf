data "aws_ami" "ubuntu_2404" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu_2404.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.devops_public_subnet.id
  vpc_security_group_ids      = [aws_security_group.devops_public_sg.id]
  private_ip                  = "10.0.0.5"
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ssm_instance_profile.name

  key_name = var.ssh_key_name

  tags = merge(local.tags, {
    Name = "web-server"
    Role = "web"
  })
}

resource "aws_eip" "web_eip" {
  domain = "vpc"
  tags = merge(local.tags, {
    Name = "web-eip"
  })
}

resource "aws_eip_association" "web_eip_assoc" {
  instance_id   = aws_instance.web.id
  allocation_id = aws_eip.web_eip.id
}

resource "aws_instance" "controller" {
  ami                         = data.aws_ami.ubuntu_2404.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.devops_private_subnet.id
  vpc_security_group_ids      = [aws_security_group.devops_private_sg.id]
  private_ip                  = "10.0.0.135"
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.ssm_instance_profile.name

  key_name = var.ssh_key_name

  tags = merge(local.tags, {
    Name = "ansible-controller"
    Role = "controller"
  })
}

resource "aws_instance" "monitoring" {
  ami                         = data.aws_ami.ubuntu_2404.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.devops_private_subnet.id
  vpc_security_group_ids      = [aws_security_group.devops_private_sg.id]
  private_ip                  = "10.0.0.136"
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.ssm_instance_profile.name

  key_name = var.ssh_key_name

  tags = merge(local.tags, {
    Name = "monitoring-server"
    Role = "monitoring"
  })
}

