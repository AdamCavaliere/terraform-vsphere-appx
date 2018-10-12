provider "vsphere" {
  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_virtual_machine" "template" {
  name          = "Ubuntu"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datacenter" "dc" {
  name = "PacketDatacenter"
}

data "vsphere_datastore" "datastore" {
  name          = "datastore1"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "MainCluster"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "vm" {
  name                        = "${var.vm_name}_${count.index + 1}"
  resource_pool_id            = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_id                = "${data.vsphere_datastore.datastore.id}"
  count                       = "${var.vm_count}"
  num_cpus                    = "${var.cpu_count}"
  memory                      = "${var.memory}"
  guest_id                    = "ubuntu64Guest"
  wait_for_guest_net_routable = false
  wait_for_guest_net_timeout  = 0

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  tags = ["${data.vsphere_tag.tag1.id}"]

  disk {
    label            = "disk0"
    size             = "${var.disk_size}"
    thin_provisioned = true
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      network_interface {}

      ipv4_gateway    = "10.100.0.1"
      dns_server_list = ["8.8.8.8"]

      linux_options {
        host_name = "${var.vm_name}"
        domain    = "vsphere.local"
      }
    }
  }
}
