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
    type    = "virtio"
    size    = "20G"
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"

    # Configuration de l'interface réseau avec une adresse IP statique
    ip_address = "192.168.1.100"   # Adresse IP statique que vous souhaitez attribuer
    netmask    = "255.255.255.0"   # Masque de sous-réseau correspondant
    gateway    = "192.168.1.1"     # Passerelle par défaut pour cette interface
  }

  # Autres configurations de la machine virtuelle
}
