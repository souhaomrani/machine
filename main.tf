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
  pm_api_url          = "https://192.168.127.134:8006/api2/json"
  pm_user             = "root@pam!souhasouha"
  pm_password         = "faf0b3f2-8df5-48ec-b726-6fadc60aa5d1"
}

resource "proxmox_vm_qemu" "terraform-test" {
  target_node  = "pve"                    # Hôte Proxmox sur lequel créer la machine virtuelle
  hostname     = "terraform-test"         # Nom de la machine virtuelle
  ostemplate   = "local:vztmpl/almalinux-9-default_20221108_amd64.tar.xz"  # Chemin vers le modèle de la machine virtuelle
  password     = "terraform"              # Mot de passe de la machine virtuelle
  unprivileged = true                     # Exécuter le processus de la machine virtuelle sans privilèges

  rootfs {
    storage = "local-lvm"   # Stockage pour le système de fichiers racine de la machine virtuelle
    size    = "5G"          # Taille du système de fichiers racine
  }

  network {
    name   = "eth0"     # Nom de l'interface réseau dans la machine virtuelle
    bridge = "vmbr0"    # Pont réseau associé
    ip     = "dhcp"     # Attribution IP via DHCP
  }
}
