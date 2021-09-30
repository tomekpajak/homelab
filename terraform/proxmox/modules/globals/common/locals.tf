locals {
  ssh_info = {
    user = "terraform"
    key  = file("~/.ssh/id_rsa")
  }
  pve_info = {
    host         = "homelab.dom"
    api_url      = "https://homelab.dom:8006/api2/json"
    user         = "${local.ssh_info.user}@pve"
    tls_insecure = true
  }
  vm_consts = {
    target_node = "homelab"
    os = tomap({
      "linux" = {
        qemu_os_type     = "l26"
        qemu_guest_agent = 1
      }
      "windows" = {
        qemu_os_type     = "win10"
        qemu_guest_agent = 1
      }
    })
    storage = tomap({
      "hdd" = "data-hdd"
      "sdd" = "data-sdd"
    })
  }
}
