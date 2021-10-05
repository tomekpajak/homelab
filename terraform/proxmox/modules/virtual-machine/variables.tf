variable "pve_target_node" {
  type = string
}

variable "name" {
  type = string
}

variable "id" {
  type    = number
  default = 0
}

variable "onboot" {
  type    = bool
  default = false
}

variable "bootorder" {
  type    = string
  default = "dc"
}

variable "bios" {
  type    = string
  default = "seabios"
}

variable "additional_wait" {
  type = number
  default = 15
}

variable "os_config" {
  type = object({
    os = object({
      qemu_os_type     = string
      qemu_guest_agent = number
    })
    iso            = string
    cloud_init_iso = string
  })
}

variable "resources_config" {
  type = object({
    cores = number
    memory = object({
      min_gb = number
      max_gb = number
    })
    storages = list(object({
      storage = string
      size_gb = string
    }))
    interfaces = list(object({
      mac      = string
      bridge   = string
      tag      = number
      firewall = bool
    }))
  })
}
