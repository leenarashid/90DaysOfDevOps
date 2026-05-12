variable "instances" {
    description = "Map to the instances"
    type = map(object({
        ami = string
        instance_type = string
        os_family = string
        user = string
         }))

default = {
   control-node-ubuntu ={
         ami = "ami-06c6960215cdac78d"
         instance_type = "t2.micro"
         os_family =  "ubuntu"
         user = "ubuntu"
   }


   worker-node-amazon-linux ={
         ami = "ami-02166c47d457c16a3"
         instance_type = "t2.micro"
         os_family =   "amazon"
         user = "ec2-user"
   }

   worker-node-ubuntu ={
         ami = "ami-06c6960215cdac78d"
         instance_type = "t2.micro"
         os_family = "ubuntu"
         user = "ubuntu"
   }
}
}