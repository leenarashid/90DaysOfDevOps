locals {
    inventory = {
        for name,inst in aws_instance.my_instance: 
          name => {
            public_ip = inst.public_ip
            user = var.aws_instance[name].user
            os_family = var.aws_instance[name].os_family
          }

    }
    ubuntu_hosts = {for name,inst in local.inventory:  name => inst
     if inst.os_family == "Debian"}
}

resource "local_file" "observability_inventory" {
    content = templatefile("${path.module}/templates/inventory.tpl", {
    ssh_key_path = var.ssh_key_path
    ubuntu= local.ubuntu_hosts
    })
    filename = "${path.module}/../dev/hosts.ini"
    }