# Build and Secure Network in GCP

## Prerequisites

- Ansible
- Terraform

## Variables

- Input your own variables in vars.tf and terraform.tfvars files

## Generate SSH Key Pair

- Run the following command to generate elliptic curve ssh key pair

```bash
ssh-keygen -t ed25519 -f ~/.ssh/ansbile_ed25519 -C ansible
```

- **Optionally**, you can generate RSA key pair

```bash
ssh-keygen -t rsa -f ~/.ssh/ansbile -C ansible -b 2048
```

## Add SSH Key to GCP Project

- Go to compute engine section
- Click Metadata
- Select `SSH KEYS` tab and click `ADD SSH KEY`
- Upload public `ansbile_ed25519.pub` key
  - `cat ~/.ssh/ansbile_ed25519.pub`

## Create Ansible Playbook for Nginx Installation

- Create `ansible/roles/nginx/tasks/main.yaml` task
- Create `ansible/hosts` to specify on what instances nginx should be installed
- Create `ansible/nginx.yaml` playbook
- Create Ansible config `ansible/ansible.cfg` to skip host key verification

## To apply infrastructure use following commands

- Run `terraform init` to download provider and plugins
- Run `terraform apply` to apply infrastructure instance in GCP
