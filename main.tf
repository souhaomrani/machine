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
  name         = "ubuntu.robert.local"  # Nom de la machine virtuelle
  target_node  = "pve"                  # Noeud Proxmox sur lequel déployer la machine virtuelle
  clone        = "9999"       # Modèle à cloner pour la machine virtuelle
  memory       = 2048                   # Mémoire assignée à la machine virtuelle (en Mo)
  cores        = 2                      # Nombre de cœurs de processeur assignés à la machine virtuelle

  network {
    model  = "virtio"                   # Modèle de carte réseau
    bridge = "vmbr0"                    # Pont réseau associé
  }

  disk {
    id           = 0                     # ID du disque
    storage      = "local-lvm"           # Stockage pour le disque
    size         = "20G"                 # Taille du disque principal
    type         = "scsi"                # Type de contrôleur de disque
    filename     = "local:9999/vm-9999-cloudinit.qcow2"  # Chemin vers le disque cloud-init
  }
}
