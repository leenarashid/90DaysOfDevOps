locals {
    inventory = {
        for name , inst in aws_instance.my_instance : name => {
          public_ip = inst.public_ip
          user = var.instances[name].user
          os_family = var.instances[name].os_family
    }
    }
    ubuntu_hosts = { for name , inst in local.inventory : name => inst if inst.os_family == "ubuntu"}
    redhat_hosts = { for name, inst in local.inventory : name => inst if inst.os_family == "redhat"}
    amazon_hosts = { for name, inst in local.inventory : name => inst if inst.os_family == "amazon"}
    master_node_hosts = { for name, inst in local.inventory : name => inst   if length(regexall("^master_node", name)) > 0 }

    
}

resource "local_file" "ansible_inventory" {
   content = templatefile("${path.module}/templates/inventory.tpl", {
    ssh_key_path = var.ssh_key_path
    ubuntu       = local.ubuntu_hosts
    redhat       = local.redhat_hosts
    amazon       = local.amazon_hosts
    master_node_hosts     = local.master_node_hosts
  })

  filename        = "${path.module}/../inventories/dev/hosts.ini"
  file_permission = "0644"
}