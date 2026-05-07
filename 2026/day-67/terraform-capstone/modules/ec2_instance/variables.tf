variable environment{
    description = "Environment"
    type = string
}
variable project_name {
    description = "Project Name"
    type = string
}

variable security_group_ids {
    description = "List of Security Group IDs"
    type = list(string)
}
variable subnet_id {
    description =  "Subnet ID"
    type = string
}  

variable "ami_id" {
   description = "ami_id"
   type = string
  }
variable "instance_type" {
   description = "Instance Type"
   type = string
  }

