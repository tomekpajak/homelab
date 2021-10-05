terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.8.0"
    }
  }
  required_version = "1.0.8"
}
