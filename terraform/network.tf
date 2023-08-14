data "aws_availability_zones" "available" {
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = "192.168.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "devops_case_ecs_vpc"
  }
}

resource "aws_subnet" "sn1" {
  cidr_block              = "192.168.1.0/24"
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "sn2" {
  cidr_block              = "192.168.2.0/24"
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "sn3" {
  cidr_block              = "192.168.3.0/24"
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true
}

# Internet Gateway for the public subnets
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

# Route table for the public subnets
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

}

# Associate public subnets with the internet gateway
resource "aws_route_table_association" "route1" {
  route_table_id = aws_route_table.rt.id
  subnet_id      = aws_subnet.sn1.id
}
resource "aws_route_table_association" "route2" {
  route_table_id = aws_route_table.rt.id
  subnet_id      = aws_subnet.sn2.id
}
resource "aws_route_table_association" "route3" {
  route_table_id = aws_route_table.rt.id
  subnet_id      = aws_subnet.sn3.id
}
