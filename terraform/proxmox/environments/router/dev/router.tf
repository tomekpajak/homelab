# I am doing here:
# - creating VM for router
# - creating virtual disk with config.xml file and attaching it to the VM

module "copy_config_xml" {
  source = "../../../modules/pvm-copy-folders"

  pve     = local.iso_cloud_config.pve
  folders = {for idx, val in local.iso_cloud_config.folders: idx => val}
}

module "router" {
  source = "../../../modules/virtual-machine"

  additional_wait  = local.additional_wait
  pve_target_node  = local.vm_config.pve_target_node
  name             = local.vm_config.name
  id               = local.vm_config.id
  onboot           = local.vm_config.onboot
  bootorder        = local.vm_config.bootorder
  os_config        = local.vm_config.os_config
  resources_config = local.vm_config.resources_config

  depends_on = [
    module.copy_config_xml
  ]
}

module "attach_storage_with_config_xml" {
  source = "../../../modules/pvm-invoke-cmds"

  pve      = local.iso_cloud_config.pve
  commands = local.iso_cloud_config.commands

  depends_on = [
    module.copy_config_xml
  ]
}
