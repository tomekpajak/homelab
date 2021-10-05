terraform {
  backend "local" {
    path = "../../../../backend/proxmox/environments/router/dev/terraform.tfstate"
  }
}

module "common" {
  source = "../../../modules/globals/common"
}

provider "proxmox" {
  pm_api_url      = module.common.pve_info.api_url
  pm_tls_insecure = module.common.pve_info.tls_insecure
}
