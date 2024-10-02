variable "vpc_cidr_block" {
  type = string
}

variable "subnet_cidr_block" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "sg_allowed_ports" {
  type = list(string)
}

variable "instance_type" {
  type = string
}

variable "public_sshkey_location" {
  type = string
}

variable "ansible_playbook" {
  type = string
}

variable "private_sshkey_location" {
  type = string
}


# variable "ssh_private_key" {
#   type = string
# }

# variable "ansible_user" {
#   type = string
# }

