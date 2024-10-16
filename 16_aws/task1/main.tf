data "aws_region" "current" {}

resource "aws_vpc" "task1_vpc" {
  cidr_block       = var.cidr
  instance_tenancy = "default"
  tags = {
    Name = "${var.environment}-vpc"
  }
}

resource "aws_subnet" "task1_pub_subnet" {
  vpc_id                  = aws_vpc.task1_vpc.id
  cidr_block              = var.publicCIDR
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.environment}-subnet"
  }
}

resource "aws_internet_gateway" "task1_igw" {
  vpc_id = aws_vpc.task1_vpc.id
  tags = {
    Name = "${var.environment}-igw"
  }
}

resource "aws_route_table" "task1_rtb" {
  vpc_id = aws_vpc.task1_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.task1_igw.id
  }
  tags = {
    Name = "${var.environment}-rtb"
  }
}

resource "aws_route_table_association" "task1_rtba" {
  route_table_id = aws_route_table.task1_rtb.id
  subnet_id      = aws_subnet.task1_pub_subnet.id
}

resource "aws_security_group" "task1_sg" {
  name        = "public_webservers"
  description = "SG for webservers in public subnet"
  vpc_id      = aws_vpc.task1_vpc.id
  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.environment}-sg"
  }
}

resource "aws_instance" "task1_ec2" {
  availability_zone      = var.availability_zone
  ami                    = var.instance_AMI
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.task1_pub_subnet.id
  vpc_security_group_ids = [aws_security_group.task1_sg.id]
  user_data              = file("${path.module}/entry_script.sh")
  tags = {
    Name = "${var.environment}-webserver"
  }
}