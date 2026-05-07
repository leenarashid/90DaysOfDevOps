variable "project_name" {
  type    = string
  default = "terraweek"
}

variable "cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ingress_ports" {
  type    = list(number)
  default = [22, 80]
}
variable "availability_zone" {
  description = "Availability Zone"
  type        = string
}
# variable "vpc_id" {
#   description = "VPC"
#   type        = string
# }

variable "availability_zone_map" {
  type = map(string)

  default = {
    dev  = "us-west-2a"
    staging= "us-west-2b"
    prod  = "us-west-2c"
  }
}
# variable "security_group_name" {
#   description = "Security group Name"
#   type        = string
# }