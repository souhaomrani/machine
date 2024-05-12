terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

provider "proxmox" {
  pm_api_url  = var.pm_api_url
  pm_user     = var.pm_user
  pm_password = var.pm_password
}

resource "proxmox_vm_qemu" "terraform-test" {
  target_node = "pve"
  vmid        = 9999
  name        = "ubuntu.robert.local"
  os_type     = "ubuntu"  # Assurez-vous d'adapter cette valeur à votre OS
  clone       = true
  full_clone  = false
  storage     = "local-lvm"  # Assurez-vous de spécifier le stockage approprié

  network {
    model  = "virtio"
    bridge = "vmbr0"  # Assurez-vous d'utiliser le bon bridge réseau
  }

  # Spécifiez d'autres configurations de la machine virtuelle si nécessaire
}
