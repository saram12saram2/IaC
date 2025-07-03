# TODO: развернуть проект на Terraform и Ansible для создания и настройки сервера в DigitalOcean.

terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

# Get existing SSH key
data "digitalocean_ssh_key" "ssh_key" {
  name = var.ssh_key_name
}

# Create droplet
resource "digitalocean_droplet" "web" {
  image  = "ubuntu-22-04-x64"
  name   = "web-server"
  region = "fra1"
  size   = "s-1vcpu-1gb" # минимальный размер
  ssh_keys = [
    data.digitalocean_ssh_key.ssh_key.id
  ]

  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.private_key_path)
    timeout     = "2m"
  }

  # быстрая установка nginx прямо через Terraform, чтобы что-то работало до Ansible, 
  # не заменяет полноценную настройку Ansible
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt update",
      "sudo apt install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
      "echo '<h1>Hello from Terraform!</h1>' | sudo tee /var/www/html/index.html"
    ]
  }

}

