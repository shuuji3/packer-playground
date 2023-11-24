packer {
  required_plugins {
    vagrant = {
      version = "~>1"
      source  = "github.com/hashicorp/vagrant"
    }
  }
}

source "vagrant" "ubuntu" {
  communicator = "ssh"
  source_path = "generic/ubuntu2310"
  provider = "virtualbox"
  add_force = true
}

build {
  sources = ["source.vagrant.ubuntu"]
}
