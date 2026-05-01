variable "ec2_instance_ami_id" {
   description = "Hold the value of ami_id"
   #default = "ami-06c6960215cdac78d"
   type = string
  }
variable "ec2_instance_type" {
   description = "Hold the value of instance_type"
   default = "t3.micro"
   type = string
  }
  variable "ec2_subnet_id" {
   description = "Hold the value of subnet_id"
   #default = "subnet-0e86e2dfbd41f90aa"
   type = string
  }
  variable "ec2_security_group_ids" {
   description = "Hold the value of security_group_ids"
   default = []                                   # changing it to a list
   type    = list(string)
  }
  variable "ec2_instance_name" {
   description = "Hold the value of instance_name"
   #default = "Terra-Week-instance"
   type = string
  }
  variable "ec2_instance_tags" {
   description = "Hold the value of instance tags"
   default = {}                   #changing it to a map
   type = map(string)
  }
  variable "key_name" {
  type        = string
  description = "Key pair name"
}