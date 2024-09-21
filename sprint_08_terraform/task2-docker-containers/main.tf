resource "local_file" "nginx_content" {
  content  = "My First and Lastname: ${var.my_name}"
  filename = "${path.module}/nginx_data/index.html"
}

resource "docker_image" "get" {
  for_each     = var.docker_images
  name         = each.value
  keep_locally = false
}

resource "docker_container" "nginx" {
  name  = "nginx"
  image = docker_image.get["nginx"].image_id
  volumes {
    host_path      = abspath("${path.module}/nginx_data")
    container_path = "/usr/share/nginx/html"
  }
  ports {
    internal = 80
    external = 8080
  }
}

resource "docker_container" "db" {
  name  = "mariadb"
  image = docker_image.get["mariadb"].image_id
  env = [
    "MARIADB_ROOT_PASSWORD=${var.db_root_password}"
  ]
  ports {
    internal = 3306
    external = 3306
  }
}