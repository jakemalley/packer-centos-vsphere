# vCenter Details
variable "vcenter_server" {
  type = string
}

variable "vcenter_username" {
  type = string
}

variable "vcenter_password" {
  type = string
}

variable "vcenter_cluster" {
  type = string
}

variable "vcenter_resource_pool" {
  type = string
}

variable "vcenter_datastore" {
  type = string
}

variable "vcenter_folder" {
  type = string
}

variable "vcenter_insecure_connection" {
  type    = bool
  default = false
}

# VM Details
variable "vm_name" {
  type    = string
  default = "packer-template"
}

variable "vm_guest_os_type" {
  type    = string
  default = "rhel7_64Guest"
}

variable "vm_vcpus" {
  type    = string
  default = "2"
}

variable "vm_memory" {
  type    = string
  default = "2048"
}

variable "vm_disk" {
  type    = string
  default = "61440"
}

variable "vm_network" {
  type    = string
  default = "VM Network"
}

variable "vm_notes" {
  type    = string
  default = "Template created using Packer on {{ isotime }}"
}

# Installation Sources
variable "install_repo" {
  type    = string
}

variable "install_boot_iso" {
  type    = string
  default = ""
}

variable "install_boot_iso_checksum" {
  type    = string
  default = "none"
}

# Kickstart / Automated Install
variable "install_ks" {
  type    = string
  default = "kickstart.cfg"
}

# SSH Information
variable "ssh_username" {
  type    = string
  default = "root"
}

variable "ssh_password" {
  type    = string
  default = "redhat123"
}
