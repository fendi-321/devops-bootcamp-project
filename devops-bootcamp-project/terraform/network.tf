resource "aws_vpc" "devops_vpc" {
  cidr_block           = local.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.tags, {
    Name = "devops-vpc"
  })
}

resource "aws_internet_gateway" "devops_igw" {
  vpc_id = aws_vpc.devops_vpc.id

  tags = merge(local.tags, {
    Name = "devops-igw"
  })
}

resource "aws_subnet" "devops_public_subnet" {
  vpc_id                  = aws_vpc.devops_vpc.id
  cidr_block              = local.public_subnet_cidr
  map_public_ip_on_launch = true

  tags = merge(local.tags, {
    Name = "devops-public-subnet"
  })
}

resource "aws_subnet" "devops_private_subnet" {
  vpc_id                  = aws_vpc.devops_vpc.id
  cidr_block              = local.private_subnet_cidr
  map_public_ip_on_launch = false

  tags = merge(local.tags, {
    Name = "devops-private-subnet"
  })
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = merge(local.tags, {
    Name = "devops-ngw-eip"
  })
}

resource "aws_nat_gateway" "devops_ngw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.devops_public_subnet.id

  tags = merge(local.tags, {
    Name = "devops-ngw"
  })

  depends_on = [aws_internet_gateway.devops_igw]
}

resource "aws_route_table" "devops_public_route" {
  vpc_id = aws_vpc.devops_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops_igw.id
  }

  tags = merge(local.tags, {
    Name = "devops-public-route"
  })
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.devops_public_subnet.id
  route_table_id = aws_route_table.devops_public_route.id
}

resource "aws_route_table" "devops_private_route" {
  vpc_id = aws_vpc.devops_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.devops_ngw.id
  }

  tags = merge(local.tags, {
    Name = "devops-private-route"
  })
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.devops_private_subnet.id
  route_table_id = aws_route_table.devops_private_route.id
}

