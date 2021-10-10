resource "null_resource" "pvm_invoke_cmds" {
  connection {
    timeout     = "10s"
    type        = "ssh"
    host        = var.pve.host
    user        = var.pve.ssh_user
    private_key = var.pve.ssh_key
  }

  provisioner "remote-exec" {
    inline = var.commands
  }
}
