variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive   = true
}

variable "ssh_key_name" {
  description = "Name of the SSH key in DigitalOcean"
  type        = string
  default     = "my-ssh-key"
}

variable "private_key_path" {
  description = "Path to your private SSH key"
  type        = string
  default     = "~/.ssh/id_rsa"
}