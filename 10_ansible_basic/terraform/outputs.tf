output "server_public_ip" {
  value = aws_instance.ec2_server.public_ip
}


output "db_public_ip" {
  value = aws_instance.ec2_db.public_ip
}

# output "ami_id" {
#   value = data.aws_ami.linux_image.id
# }
