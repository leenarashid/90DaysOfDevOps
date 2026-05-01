variable "ec2_instance_vpc_id"{
    description = "VPC id"
    
    type = string
}

variable "ec2_instance_security_group_name"{
    description = "Security Group id"
  
    type =  string
}
variable "ec2_instance_ingress_ports"{
    description = "Ports for incoming traffic"
    default = [80,22]
    type = list(number)
}
variable "ec2_instance_sg_tags" {
  description = "Tags for security group"
  type        = map(string)
  default     = {}
}