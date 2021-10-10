variable "pve" {
  type = object({
    host     = string
    ssh_user = string
    ssh_key  = string
  })
}

variable "commands" {
  type = list(string)
}
