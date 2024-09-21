variable "docker_images" {
  type = map(string)
}

variable "my_name" {
  type = string
}

variable "db_root_password" {
  type      = string
  sensitive = true
  default = "placeholder"
}

