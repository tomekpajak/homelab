variable "pve" {
  type = object({
      host = string
      ssh_user = string
      ssh_key = string
  })
}

variable "folders" {
  type = map(object({
    source = string
    target = string
  }))  
}
