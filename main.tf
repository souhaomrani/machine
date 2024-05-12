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
# Création de la machine virtuelle
resource "proxmox_vm_qemu" "terraform-test" {
  target_node = var.target_node
  vmid        = 9999
  name        = var.template
  os_type     = "ubuntu"
  
  # Configuration du disque
  disk {
    storage = "local-lvm"
    size    = "10G"
  }
  
  # Configuration du réseau
  network {
    model  = "virtio"
    bridge = "vmbr0"
    ip     = "192.168.1.100"    # Adresse IP statique à attribuer à la machine virtuelle
    netmask = "255.255.255.0"   # Masque de sous-réseau correspondant
    gateway = "192.168.1.1"     # Passerelle par défaut pour cette interface
  }
  
  # Spécifiez d'autres configurations de la machine virtuelle si nécessaire
}
