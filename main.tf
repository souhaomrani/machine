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
  pm_api_url   = "https://your-proxmox-host:8006/api2/json"
  pm_user      = "your-proxmox-user"
  pm_password  = "your-proxmox-password"
  pm_tls_insecure = true  # Utiliser true si vous ne vérifiez pas le certificat SSL
}

# Définition de la machine virtuelle Proxmox avec Cloud-Init
resource "proxmox_vm_qemu" "my_vm" {
  name        = "my-vm"
  target_node = "proxmox-node-1"  # Remplacez par le nœud Proxmox cible
  clone       = "1804"  # Remplacez par l'ID du template à cloner

  # Configuration Cloud-Init
  clone_wait_for_network = true
  cloudinit = file("cloud-init.yaml")  # Fichier Cloud-Init

  # Autres configurations de la VM
  memory = 1024
  cores  = 2
}
