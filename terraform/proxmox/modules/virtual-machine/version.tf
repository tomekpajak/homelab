terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "~> 2.8"
    }
  }
  required_version = ">= 1.0"
}
