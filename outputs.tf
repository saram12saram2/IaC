output "droplet_ip" {
  description = "Public IP address of the droplet"
  value       = digitalocean_droplet.web.ipv4_address
}

output "ssh_command" {
  description = "Command to SSH into the droplet"
  value       = "ssh root@${digitalocean_droplet.web.ipv4_address}"
}