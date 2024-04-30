terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

provider "proxmox" {
  pm_api_url         = var.pm_api_url
  pm_api_token_id    = var.pm_user
  pm_api_token_secret = var.pm_password
  pm_tls_insecure    = true  # Ajustez cette option en fonction de votre configuration de sécurité
}

resource "proxmox_vm_qemu" "ubuntu_vm" {
  name        = "ubuntu_vm"
  target_node = var.target_node
  template    = "ubuntu.robert.local"
  memory      = 2048
  cores       = 2

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  scsihw = "virtio-scsi-pci"
  agent  = true  # Utilisez true pour activer l'agent QEMU

  # Utilisation de "cloudinit" pour spécifier le chemin vers le cloud-init
  cloudinit = "local:cloudinit"

  # Tags pour identifier la VM
  tags = ["template", "test"]
}

