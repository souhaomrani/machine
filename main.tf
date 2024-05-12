# providers.tf or main.tf, naming is up to you
terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

provider "proxmox" {
  pm_api_url     = var.pm_api_url
  pm_user        = var.pm_user
  pm_password    = var.pm_password
}

resource "proxmox_vm_qemu" "terraform-test" {
  target_node  = var.target_node
  hostname     = "terraform-test"
  ostemplate   = "local:vztmpl/almalinux-9-default_20221108_amd64.tar.xz"
  password     = "terraform"
  unprivileged = true

  rootfs {
    storage = "local-lvm"
    size    = "5G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }
}
