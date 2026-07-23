output "server_output" {
    description = "Prometheus Server Details"
    value = {
       for name,inst in aws_instance.prometheus_server: name =>
        {
        
        public_ip = inst.public_ip
        user = var.instance[name].user
        os_family =  var.instance[name].os_family
    }

    }
}
output "inventory_file" {
  description = "Path to the auto-generated Ansible inventory"
  value       = local_file.inventory.filename
}