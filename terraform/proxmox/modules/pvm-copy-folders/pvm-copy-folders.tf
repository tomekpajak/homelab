resource "null_resource" "pvm_copy_folders" {
  for_each = var.folders

  connection {
    timeout     = "10s"
    type        = "ssh"
    host        = var.pve.host
    user        = var.pve.ssh_user
    private_key = var.pve.ssh_key
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p ${each.value.target}"
    ]
  }

  provisioner "file" {
    source      = each.value.source
    destination = each.value.target
  }
}
