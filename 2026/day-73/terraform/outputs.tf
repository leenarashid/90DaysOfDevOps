output "instance_details" {
  description = "Details of all EC2 instances"
  value = {
    for name, inst in aws_instance.my_instance : name => {
      public_ip = inst.public_ip
      user      = var.instance[name].user
      os_family = var.instance[name].os_family
    }
  }
}

output "inventory_file" {
  description = "Path to the auto-generated Ansible inventory"
  value       = local_file.inventory.filename
}