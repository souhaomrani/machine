# Configuration Terraform
terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

# Déclaration du fournisseur Proxmox
provider "proxmox" {
  pm_api_url  = var.pm_api_url
  pm_user     = var.pm_user
  pm_password = var.pm_password
}

resource "proxmox_vm_qemu" "terraform-test" {
  target_node = var.target_node
  vmid        = 9999
  name        = var.template
  os_type     = "ubuntu"
  clone       = true
  full_clone  = false

  disk {
    storage = "local-lvm"
    type    = "virtio"  # Ajoutez le type de disque (par exemple, virtio)
    size    = "20G"     # Ajoutez la taille du disque (par exemple, 20G)
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  # Spécifiez d'autres configurations de la machine virtuelle si nécessaire
}

