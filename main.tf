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
  target_node = var.target_node
  vmid        = 9999
  name        = "terraform-test"
  os_type     = "cloud-init"
  clone       = true
  full_clone  = false
  ostemplate  = "local:vztmpl/almalinux-9-default_20221108_amd64.tar.xz"
  cipassword  = "terraform"
  
  network {
    model  = "virtio"
    bridge = "vmbr0"
    macaddr = "52:54:00:12:34:56"
  }
}
