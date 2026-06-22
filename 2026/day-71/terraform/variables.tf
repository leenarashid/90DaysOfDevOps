variable "aws_region"{
    type = string
    default = "us-west-2"
    description = "AWS Region"
}
variable "aws_key_pair"{
    type = string
    default = "tf-ansible-key" ### remember
    description = "AWS Keypair" 
}
variable "instance_type" {
    type = string
    default = "t2.micro"
    description =  "EC2 Instance Type"
}
variable "volume_size" {
    type= number
    default = 10
    description = "EC2 Instance volume size"
}
variable "volume_type" {
    type = string
    default = "gp3"
    description = "EC2 Instance volume type"
}
variable "ssh_key_path" {
    type = string
    default = "/home/ubuntu/ansible/keys/tf-ansible-key" ###remember
    description = "Path to the key"
}
variable "instances"{
    description = "AWS instances details"
    type = map(object({
       ami = string
       instance_type = string
       user = string
       os_family = string 
    }))
    default = {
        master-node-ubuntu ={
            ami = "ami-06c6960215cdac78d"
            user = "ubuntu"
            os_family = "ubuntu"
            instance_type = "t2.micro"

        }
        worker-node-ubuntu ={
            ami = "ami-06c6960215cdac78d"
            user = "ubuntu"
            os_family = "ubuntu"
            instance_type = "t2.micro"

        }
        worker-node-redhat = {
            ami = "ami-0c531417232be874d"
            user = "ec2-user"
            os_family = "redhat"
            instance_type = "t2.micro"
        }
         worker-node-amazon = {
            ami = "ami-029a761f237195c2c"
            user = "ec2-user"
            os_family = "amazon"
            instance_type = "t2.micro"
        }

     }


}
