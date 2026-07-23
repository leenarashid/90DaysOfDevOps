output "server_details" {
    description = "Server Details"
    value = {
     
    for  name,inst in aws_instance.my_instance: name => 
    {
      public_ip = inst.public_ip
      user = var.aws_instance[name].user
      os_family= var.aws_instance[name].os_family
}
}
     }
output "inventory_file" {
    description = "Path to the auto-generated Ansible inventory"
    value = local_file.observability_inventory.filename
}