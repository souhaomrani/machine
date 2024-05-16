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
  pm_api_url      = var.pm_api_url
  pm_user         = var.pm_user
  pm_password     = var.pm_password
  pm_tls_insecure = true  # À utiliser avec précaution, ne pas vérifier le certificat SSL
}

# Définition de la machine virtuelle Proxmox avec Cloud-Init
resource "proxmox_vm_qemu" "my_vm" {
  name        = "my-vm"
  target_node = pve
  clone       = "var.1804"  # Utilisez le nom du template à cloner

  # Configuration Cloud-Init
  provision {
    command = "clone"
    clone   = {
      full = true
    }
  }

  # Autres configurations de la VM
  memory = 1024
  cores  = 2
}
