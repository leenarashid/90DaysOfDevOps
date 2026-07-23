variable "aws_region"  {
    description = "Server region"
    type = string
    default = "us-west-2"
}
variable "key_pair" {

    description = "Server Key Pair"
    type = string
    default = "server_key"  ##########

}
variable "ssh_key_path" {
    description = "Server ssh key path"
    type = string
    default = "~/keys/server_key"

}


variable "instance_type" {
    description = "Server state"
    type = string
    default = "t2.large"

}
variable "volume_size" {
     description = "Server Volume Size"
     type = number
     default = 20
  
}
variable "volume_type" {
     description = "Server Volume Type"
     type = string
     default = "gp3"
}
variable "instance" {
     description = "Server Details"
     type = map(object({

        ami = string
        instance_type = string
        user = string
        os_family = string
     }))
     default = {
        prometheus_server = {
        ami = "ami-02167eae61967e403"
        instance_type = "t2.large" ##########33
        user = "ubuntu"
        os_family = "Debian"
}
     }
}