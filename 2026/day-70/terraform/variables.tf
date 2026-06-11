variable "aws_region" {
    description = "AWS region for Infrastructure"
    type = string
    default = "us-west-2"
}
variable "instance_type" {
    description = "EC2 instance type"
    type = string
    default = "t3.micro"
}
variable "key_name" {
    description = "SSH key pair name"
    type = string
    default = "terra-ansible-key"
}
variable volume_size {
    description = "Root volume size in GBs"
    type = number
    default = 10

}
variable volume_type {
    description = "Root Volume type"
    type = string
    default = "gp3"
}
variable "ssh_key_path" {
    description = "Path to SSH private key on the control node"
    type = string
    #default = "/keys/terra-ansible-key"
    default = "${path.root}/keys/terra-ansible-key"
}
variable "instances"{
    description = "Instance Details"
    type = map(object({
        ami = string
        instance_type = string
        user = string
        os_family = string
    }))
 default = {
   controlnode-ubuntu ={
         ami = "ami-06c6960215cdac78d"
         instance_type = "t2.micro"
         os_family =  "Debian"
         user = "ubuntu"
   }


   worker-node-amazon-linux ={
         ami = "ami-02166c47d457c16a3"
         instance_type = "t2.micro"
         os_family =   "RedHat"
         user = "ec2-user"
   }

   worker-node-ubuntu ={
         ami = "ami-06c6960215cdac78d"
         instance_type = "t2.micro"
         os_family = "Debian"
         user = "ubuntu"
   }
}
}