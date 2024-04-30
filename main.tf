terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

provider "proxmox" {
  pm_api_url         = "https://192.168.127.134:8006/api2/json"
  pm_api_token_id    = "root@pam!souhasouha"
  pm_api_token_secret = "faf0b3f2-8df5-48ec-b726-6fadc60aa5d1"
  pm_tls_insecure    = true  # Ajustez cette option en fonction de votre configuration de sécurité
}

resource "proxmox_vm_qemu" "ubuntu_vm" {
  name            = "ubuntu-vm"
  clone           = var.template
  target_node     = "pve"
  memory = 2048
  cores  = 2

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }
disk {
    id            = 0
    storage       = "local"
    size          = "20G"
    type          = "scsi"
    iothread      = true
    storage_type  = "raw"
    filename      = "local-lvm:vm-100-disk-0"
    iso           = "/var/lib/vz/template/iso/ubuntu-20.04-server-cloudimg-amd64.img"
  }
}
}

