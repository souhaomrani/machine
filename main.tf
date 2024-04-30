provider "proxmox" {
  pm_api_url         = "https://192.168.127.134:8006/api2/json"
  pm_api_token_id    = "root@pam!souhasouha"
  pm_api_token_secret = "faf0b3f2-8df5-48ec-b726-6fadc60aa5d1"
  pm_tls_insecure    = true  # Ajustez cette option en fonction de votre configuration de sécurité
}

data "proxmox_virtual_environment_vms" "template" {
  node_name = "pve"
  tags      = ["template", "test"]  # Remplacez "test" par vos propres tags de template
}

resource "proxmox_virtual_environment_file" "cloud_user_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve"

  source_raw {
    data      = file("cloud-init/user_data")  # Assurez-vous que le chemin du fichier cloud-init est correct
    file_name = "ubuntu.${var.domain}-ci-user.yml"  # Remplacez "ubuntu" et "${var.domain}" par vos valeurs spécifiques
  }
}

resource "proxmox_virtual_environment_file" "cloud_meta_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve"

  source_raw {
    data      = templatefile("cloud-init/meta_data.tpl", { instance_id = sha1(var.vm_hostname), local_hostname = var.vm_hostname })
    file_name = "ubuntu.${var.domain}-ci-meta_data.yml"  # Remplacez "ubuntu" et "${var.domain}" par vos valeurs spécifiques
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  name      = "ubuntu.${var.domain}"
  node_name = "pve"

  on_boot = true  # Démarre automatiquement la VM après le déploiement

  agent {
    enabled = true
  }

  tags = ["test"]  # Remplacez "test" par vos propres tags pour la VM

  cpu {
    type    = "x86-64-v2-AES"
    cores   = 2
    sockets = 1
    flags   = []
  }

  memory {
    dedicated = 2048  # Taille de la mémoire en Mo
  }

  network_device {
    bridge  = "vmbr0"
    model   = "virtio"
  }

  lifecycle {
    ignore_changes = [
      network_device,
    ]
  }

  boot_order    = ["scsi0"]
  scsi_hardware = "virtio-scsi-single"

  disk {
    interface    = "scsi0"
    iothread     = true
    datastore_id = "local"
    size         =   20  # Taille du disque en Go
    discard      = "ignore"
  }

  initialization {
    datastore_id         = "local"
    interface            = "ide2"
    user_data_file_id    = proxmox_virtual_environment_file.cloud_user_config.id
    meta_data_file_id    = proxmox_virtual_environment_file.cloud_meta_config.id
  }
}
