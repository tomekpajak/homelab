resource "proxmox_vm_qemu" "vm" {
  #general configuration
  target_node = var.pve_target_node

  additional_wait = var.additional_wait

  name = var.name
  vmid = var.id

  onboot   = var.onboot
  boot     = var.bootorder
  bootdisk = "scsi1"
  bios     = var.bios

  #os configuration
  preprovision = false
  agent        = var.os_config.os.qemu_guest_agent
  qemu_os      = var.os_config.os.qemu_os_type
  iso          = var.os_config.cloud_init_iso
  disk {
    storage = "local"
    type    = "ide"
    media   = "cdrom"
    volume  = var.os_config.iso
    size    = "0M"
  }

  #resources configuration
  ##cpu
  cpu     = "host"
  sockets = 1
  cores   = var.resources_config.cores

  ##memory
  numa    = false
  memory  = var.resources_config.memory.max_gb * 1024
  balloon = var.resources_config.memory.min_gb * 1024

  ##storages
  scsihw = "virtio-scsi-single"

  dynamic "disk" {
    for_each = var.resources_config.storages

    content {
      size    = "${disk.value.size_gb}G"
      storage = disk.value.storage

      type     = "scsi"
      format   = "raw"
      iothread = 1
      discard  = "on"
    }
  }

  ##network
  dynamic "network" {
    for_each = var.resources_config.interfaces

    content {
      model    = "virtio"
      macaddr  = network.value.mac
      bridge   = network.value.bridge
      tag      = network.value.tag
      firewall = network.value.firewall
    }
  }

  serial {
    id   = 0
    type = "socket"
  }

  # Ignore changes to the network (MAC address is generated on every apply, causing TF to think this needs to be rebuilt on every apply)
  lifecycle {
    ignore_changes = [
      network
    ]
  }
}
