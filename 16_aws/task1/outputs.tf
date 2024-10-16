output "ec2_public_ip" {
  value = aws_instance.task1_ec2.public_ip
}

output "ec2_ami" {
  value = aws_instance.task1_ec2.ami
}

output "ec2_type" {
  value = aws_instance.task1_ec2.instance_type
}

output "public_vpc_id" {
  value = aws_vpc.task1_vpc.id
}

output "ec2_subnet_id" {
  value = aws_subnet.task1_pub_subnet.id
}

output "public_subnet_AZ" {
  value = aws_subnet.task1_pub_subnet.availability_zone
}

output "ec2_region" {
  value = data.aws_region.current.name
}
