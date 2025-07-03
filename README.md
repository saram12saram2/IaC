# DigitalOcean Terraform Setup

## Steps

1. **DigitalOcean Account**: Sign up at [DigitalOcean](https://www.digitalocean.com/)
2. **API Token**: Generate an API token from your DigitalOcean dashboard
3. **SSH Key**: Upload your SSH key to DigitalOcean dashboard

## Setup Steps

### 1. Install Required Tools

```bash
# Install Terraform
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

# Install Ansible
sudo apt update
sudo apt install ansible
```

### 2. Configure Your Environment

1. **Set up your SSH key** (if you don't have one):
   ```bash
   ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa
   ```

2. **Add your SSH key to DigitalOcean**:
   - Go to DigitalOcean Dashboard → Settings → Security → SSH Keys
   - Click "Add SSH Key"
   - Copy your public key: `cat ~/.ssh/id_rsa.pub`
   - Give it a name (e.g., "my-ssh-key")

3. **Update terraform.tfvars**:
   ```hcl
   do_token = "your_actual_digitalocean_token"
   ssh_key_name = "my-ssh-key"  # Name from DigitalOcean dashboard
   private_key_path = "~/.ssh/id_rsa"
   ```

### 3. Deploy with Terraform

```bash
# Initialize Terraform
terraform init

# Plan the deployment
terraform plan

# Apply the configuration
terraform apply
```

### 4. Configure with Ansible

1. **Update inventory.ini** with your droplet's IP:
   ```ini
   [webservers]
   YOUR_DROPLET_IP ansible_user=root ansible_ssh_private_key_file=~/.ssh/id_rsa
   ```

2. **Run the playbook**:
   ```bash
   ansible-playbook -i inventory.ini playbook.yml
   ```

### 5. Test Your Setup

1. **SSH into your droplet**:
   ```bash
   ssh root@YOUR_DROPLET_IP
   ```

2. **Check the website**:
   - Open your browser and go to `http://YOUR_DROPLET_IP`
   - You should see the configured webpage

## Commands Reference

```bash
# Terraform commands
terraform init          # Initialize
terraform plan          # Preview changes
terraform apply         # Apply changes
terraform destroy       # Destroy infrastructure
terraform output        # Show outputs

# Ansible commands
ansible-playbook -i inventory.ini playbook.yml  # Run playbook
ansible all -i inventory.ini -m ping            # Test connectivity
```

## File Structure

```
.
├── main.tf              # Main Terraform configuration
├── variables.tf         # Variable definitions
├── outputs.tf          # Output definitions
├── terraform.tfvars    # Variable values
├── playbook.yml        # Ansible playbook
└── inventory.ini       # Ansible inventory
```

## Security Notes

- Replace `0.0.0.0/0` with your specific IP for SSH access
- Store your API token securely (use environment variables)
- Consider using Terraform Cloud for state management
- Enable backups and monitoring for production use