resource "aws_vpc" "demo_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = "${var.tags.name}-vpc"
  }
}

resource "aws_subnet" "demo_subnet" {
  vpc_id            = aws_vpc.demo_vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.availability_zone
  tags = {
    Name = "${var.tags.name}-subnet"
  }
}

resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "${var.tags.name}-igw"
  }
}

resource "aws_default_route_table" "demo_rtb" {
  default_route_table_id = aws_vpc.demo_vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_igw.id
  }
  tags = {
    Name = "${var.tags.name}-rtb"
  }
}

resource "aws_default_security_group" "demo_sg" {
  vpc_id = aws_vpc.demo_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.tags.name}-sg"
  }
}

resource "aws_security_group_rule" "demo_sg_ingress_rules" {
  security_group_id = aws_default_security_group.demo_sg.id
  type              = "ingress"
  protocol          = "tcp"

  for_each    = toset(var.sg_allowed_ports)
  from_port   = each.value
  to_port     = each.value
  cidr_blocks = ["0.0.0.0/0"]
}

data "aws_ami" "linux_image" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "project_key.pem"
  public_key = file(var.public_sshkey_location)
}

resource "aws_instance" "ec2_server" {
  availability_zone = var.availability_zone
  ami               = data.aws_ami.linux_image.id
  instance_type     = var.instance_type

  subnet_id                   = aws_subnet.demo_subnet.id
  vpc_security_group_ids      = [aws_default_security_group.demo_sg.id]
  associate_public_ip_address = true

  key_name = aws_key_pair.ssh_key.key_name

  # user_data = file(var.entry_script) 

  tags = {
    Name    = "server_terraform"
    type = "server_terraform"
    project = "${var.tags.name}"
  }
}

resource "aws_instance" "ec2_db" {
  availability_zone = var.availability_zone
  ami               = data.aws_ami.linux_image.id
  instance_type     = var.instance_type

  subnet_id                   = aws_subnet.demo_subnet.id
  vpc_security_group_ids      = [aws_default_security_group.demo_sg.id]
  associate_public_ip_address = true

  key_name = aws_key_pair.ssh_key.key_name

  tags = {
    Name    = "db_terraform"
    type = "db_terraform"
    project = "${var.tags.name}"
  }
}

resource "null_resource" "save_outputs" {
  provisioner "local-exec" {
    command = "terraform output > ec2_public_ips.txt"
  }
  triggers = {
    always_run = "${timestamp()}"
  }
}


resource "null_resource" "update_project_vars" {
  triggers = {
    db_ip = aws_instance.ec2_db.public_ip
  }

  provisioner "local-exec" {
    command = <<EOT
    sed -i 's/db_host:.*/db_host: "${aws_instance.ec2_db.public_ip}"/' ${path.module}/../ansible/project_vars.yml
    EOT
  }
}

resource "null_resource" "configure_server_with_ansible" {
  provisioner "local-exec" {
    working_dir = "${path.module}/../ansible"
    command = "ansible-playbook --extra-vars \"db_host=${aws_instance.ec2_db.public_ip}\" ${var.ansible_playbook}"
    }
    depends_on = [ aws_instance.ec2_db, aws_instance.ec2_server ]
  }
