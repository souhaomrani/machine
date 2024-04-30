provider "proxmox" {
  pm_api_url         = "https://192.168.127.134:8006/api2/json"
  pm_api_token_id    = "root@pam!souhasouha"
  pm_api_token_secret = "faf0b3f2-8df5-48ec-b726-6fadc60aa5d1"
  pm_tls_insecure    = true  # Ajustez cette option en fonction de votre configuration de sécurité
}
resource "proxmox_virtual_machine" "ubuntu_vm" {
  name         = "ubuntu.robert.local"
  node         = var.proxmox_node
  template     = "local:vztmpl/ubuntu-20.04-server-cloudimg-amd64"
  memory       = 2048
  cores        = 2
  network {
    model   = "virtio"
    bridge  = "vmbr0"
  }
  scsihw       = "virtio-scsi-pci"
  agent        = 1
  ipconfig0    = "dhcp"
  ide2         = "local:cloudinit"
  tags         = ["template", "test"]
}



 
