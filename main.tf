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

# Déclaration de la ressource Proxmox VM QEMU (machine virtuelle)
resource "proxmox_vm_qemu" "terraform-test" {
  target_node = var.target_node
  vmid        = 9999
  name        = var.template
  os_type     = "ubuntu"
  clone       = true
  full_clone  = false
  storage     = "local-lvm"

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  # Configuration cloud-init pour la machine virtuelle
  user_data = file("${path.module}/cloud-init-config.yaml")
}
