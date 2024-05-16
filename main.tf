# Configuration Terraform
terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

# Définition du provider Proxmox
provider "proxmox" {
  pm_api_url         = var.pm_api_url
  pm_api_token_id    = var.pm_user
  pm_api_token_secret = var.pm_password
  pm_tls_insecure    = true
}
# Définition de la machine virtuelle Proxmox avec Cloud-Init
resource "proxmox_vm_qemu" "my_vm" {
  name               = "my-vm"
  target_node        = "pve"  # Utilisez le nom du nœud Proxmox cible

  clone              = var.ubuntu.robert.local  # Utilisez le nom du template à cloner défini dans les variables

  # Configuration Cloud-Init
  provisioner "file" {
    source      = "cloud-init.yaml"
    destination = "/tmp/cloud-init.yaml"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/cloud-init.yaml",
      "sudo /tmp/cloud-init.yaml"
    ]
  }

  # Autres configurations de la VM
  memory = 1024
  cores  = 2
}
