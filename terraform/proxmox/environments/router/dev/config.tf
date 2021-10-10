locals {
  additional_wait = 30
  vm_config = {
    pve_target_node = module.common.vm_consts.target_node
    name            = "router-pfsense"
    id              = 100
    onboot          = true
    bootorder       = "cd"

    os_config = {
      os             = module.common.vm_consts.os["linux"]
      iso            = "none"
      cloud_init_iso = "local:iso/pfSense-CE-2.5.2-RELEASE-amd64.iso"
    }

    resources_config = {
      cores = 2
      memory = {
        min_gb = 0.5
        max_gb = 1
      }
      storages = [
        {
          storage = module.common.vm_consts.storage.hdd
          size_gb = 3
        }
      ]
      interfaces = [
        {
          mac      = "3E:D6:3A:DA:C3:35" #used for static DHCP 192.168.2.2
          bridge   = "vmbr0"
          tag      = -1
          firewall = false
        },
        {
          mac      = "3E:D6:3A:DA:C3:01"
          bridge   = "vmbr1"
          tag      = -1
          firewall = false
        },
        {
          mac      = "3E:D6:3A:DA:C3:02"
          bridge   = "vmbr2"
          tag      = -1
          firewall = false
        },
        {
          mac      = "3E:D6:3A:DA:C3:03"
          bridge   = "vmbr3"
          tag      = -1
          firewall = false
        },
        {
          mac      = "3E:D6:3A:DA:C3:04"
          bridge   = "vmbr4"
          tag      = -1
          firewall = false
        },
        {
          mac      = "3E:D6:3A:DA:C3:05"
          bridge   = "vmbr5"
          tag      = -1
          firewall = false
        },
        {
          mac      = "3E:D6:3A:DA:C3:06"
          bridge   = "vmbr6"
          tag      = -1
          firewall = false
        },
      ]
    }
  }

  config_name   = local.vm_config.id
  config_folder = "~/${local.config_name}"
  config_img    = "${local.config_name}.img"

  iso_cloud_config = {
    pve = {
      host     = module.common.pve_info.host
      ssh_user = module.common.ssh_info.user
      ssh_key  = module.common.ssh_info.key
    }

    folders = [{
      source = "${module.common.local_config.homelab_prv}/router/dev/config/"
      target = local.config_folder
    }]

    commands = [
      "sleep 10",
      "cd /home/projects",
      "./dir2fat32.sh ${local.config_img} 5 ${local.config_folder}",
      "qm importdisk ${local.vm_config.id} ${local.config_img} data-hdd",
      "rm ${local.config_img}",
      "qm set ${local.vm_config.id} --scsi2 data-hdd:vm-${local.vm_config.id}-disk-1,iothread=1",
    ]
  }
}
