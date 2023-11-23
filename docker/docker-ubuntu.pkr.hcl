packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source  = "github.com/hashicorp/docker"
    }
  }
}

variable "docker_image" {
  type    = string
  default = "ubuntu"
}

source "docker" "ubuntu" {
  image  = var
  commit = true
}

source "docker" "alpine" {
  image  = "alpine"
  commit = true
}

build {
  name    = "learn-packer"
  sources = [
    "source.docker.ubuntu",
    "source.docker.alpine",
  ]

  provisioner "shell" {
    environment_vars = [
      "MESSAGE=hello world",
    ]
    inline = [
      "echo Adding file to Docker container",
      "echo \"MESSAGE is $MESSAGE\" > message.txt"
    ]
  }

  provisioner "shell" {
    inline = [
      "echo running Docker image",
    ]
  }

  post-processor "docker-tag" {
    repository = "learn-packer"
    tags       = ["ubuntu"]
    only       = ["docker.ubuntu"]
  }
  post-processor "docker-tag" {
    repository = "learn-packer"
    tags       = ["alpine"]
    only       = ["docker.alpine"]
  }
}
