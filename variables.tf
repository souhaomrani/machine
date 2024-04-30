variable "pm_api_url" {
  description = "URL de l'API Proxmox"
  default     = "https://192.168.127.134:8006/api2/json"  # Remplacez par l'URL de votre API Proxmox
}

variable "pm_user" {
  description = "Nom d'utilisateur Proxmox"
  default     = "root@pam!souhasouha"  # Remplacez par votre nom d'utilisateur Proxmox
}

variable "pm_password" {
  description = "Mot de passe Proxmox"
  default     = "faf0b3f2-8df5-48ec-b726-6fadc60aa5d1"  # Remplacez par votre mot de passe Proxmox
}

variable "template" {
  description = "Nom du modèle pour la création de la machine virtuelle"
  type        = string
  default     = "ubuntu.robert.local"  # Remplacez par le nom de votre modèle de machine virtuelle Proxmox
}

variable "target_node" {
  description = "Nœud Proxmox sur lequel déployer la machine virtuelle"
  default     = "pve"  # Remplacez par le nom de votre nœud Proxmox cible
}

