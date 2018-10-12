# vSphere AppX Module

This is an example module to demonstrate how you could use modules to provision VMs for applications.

## Example

```

module "appx" {
  source  = "ptfe.this-demo.rocks/SE_Org/appx/vsphere"
  version = "1.1"
  
  vm_name = "applicationx"
  cpu_count = "2"
  memory = "1024"
  tag_name = "Staging"
  disk_size = "35"
  vm_count = "2"
  
}

```

Required variables are:
 * *vm_name*
 * *vm_count*
