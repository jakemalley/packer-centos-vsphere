
# Packer Build File

build {
  sources = ["source.vsphere-iso.source-rhel7"]

  provisioner "shell" {
    script = "scripts/update.sh"
  }
  provisioner "shell" {
    script = "scripts/template.sh"
  }
}
