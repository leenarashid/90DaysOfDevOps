
# variable cidr {
#     description = "CIDR Block"
#     type = string
# }
variable environment{
    description = "Environment"
    type = string
}
variable project_name {
    description = "Project Name"
    type = string
}
# variable availability_zone {
#     description = "Availability Zone"
#     type = string
# }
variable ingress_ports {
   description = "Ingress Ports"
   type = list(number) 
  
}

variable vpc_id {
    description = "VPC"
    type =string
}
variable security_group_name {
    description = "Security group Name"
    type = string
}