data "vsphere_tag_category" "category" {
  name = "Environment"
}

data "vsphere_tag" "tag1" {
  name        = "${var.tag_name}"
  category_id = "${data.vsphere_tag_category.category.id}"
}
