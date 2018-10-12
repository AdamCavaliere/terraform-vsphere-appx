variable "disk_size" {
	description = "Size in GB of the Root Disk"
	default = "35"
}
variable "vm_name" {
	description = "Application Name"
}
variable "cpu_count" {
	description = "Number of CPUs"
	default = "2"
}
variable "memory" {
	description = "Memory size in MB"
	default = "1024"
}
variable "vm_count" {
	description = "Number of VMs to create for this application"
}
variable "tag_name" {
	description = "Tag to include, values can be Production or Staging"
	default = "Staging"
}
