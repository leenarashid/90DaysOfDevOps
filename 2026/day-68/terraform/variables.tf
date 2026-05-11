variable "instances"{
    description = "Map for ec2-instances,includes AMIs, SSH users and os_family"
    type = map(object({
    ami = string
    instance_type = string
    user = string
    os_family  = string
  }))

    default ={
     control-node-ubuntu ={
        ami = "ami-06c6960215cdac78d"
        instance_type = "t2.micro"
        user = "ubuntu"
        os_family = "ubuntu"

     }

     web-server-ubuntu = {
        ami = "ami-06c6960215cdac78d"
        instance_type = "t2.micro"
        user = "ubuntu"
        os_family = "ubuntu"

     }
     app-server-redhat = {
        ami = "ami-0c531417232be874d"
        instance_type = "t2.micro"
        user = "ec2-user"
        os_family = "redhat"

     }
     db-server-amazon-linux = {
        ami = "ami-02166c47d457c16a3"
        instance_type = "t2.micro"
        user = "ec2-user"
        os_family = "amazon"

     }

    }
}