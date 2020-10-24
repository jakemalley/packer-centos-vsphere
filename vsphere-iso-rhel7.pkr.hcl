
locals {
  iso_url = "${var.install_boot_iso == "" ? format("%s%s", var.install_repo,"images/boot.iso") : var.install_boot_iso}"
}

# Build using ISO
source "vsphere-iso" "rhel7" {
  # vCenter Details
  vcenter_server      = "${var.vcenter_server}"
  username            = "${var.vcenter_username}"
  password            = "${var.vcenter_password}"
  insecure_connection = "${var.vcenter_insecure_connection}"
  cluster             = "${var.vcenter_cluster}"
  resource_pool       = "${var.vcenter_resource_pool}"
  datastore           = "${var.vcenter_datastore}"
  folder              = "${var.vcenter_folder}"

  # VM Details
  vm_name              = "${var.vm_name}"
  guest_os_type        = "rhel7_64Guest"
  CPUs                 = "${var.vm_vcpus}"
  CPU_hot_plug         = true
  RAM                  = "${var.vm_memory}"
  RAM_hot_plug         = true
  RAM_reserve_all      = false
  disk_controller_type = ["pvscsi"]
  storage {
    disk_size             = "${var.vm_disk}"
    disk_thin_provisioned = true
  }
  network_adapters {
    network      = "${var.vm_network}"
    network_card = "vmxnet3"
  }
  notes         = "${var.vm_notes}"

  # SSH Information
  ssh_password  = "${var.ssh_password}"
  ssh_port      = 22
  ssh_timeout   = "10000s"
  ssh_username  = "${var.ssh_username}"

  # Boot ISO
  iso_url              = "${local.iso_url}"
  iso_checksum         = "${var.install_boot_iso_checksum}"

  boot_wait            = "10s"
  boot_command         = [
    "<tab>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "quiet text inst.repo=${var.install_repo} inst.ks=cdrom:/dev/sr1:/${var.install_ks}<enter><wait>",
  ]

  # Kickstart / Automated Install
  cd_files             = ["./ks/${var.install_ks}"]
  cd_label             = "cidata"

  # Create VMware template and remove cdrom
  remove_cdrom  = true
  convert_to_template  = true
}
