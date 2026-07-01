variable "aws_region"  {
    type = string
    default = "us-west-2"
    description = "AWS Region for Observability Server"
}
variable "instance_key_pair" {
    type = string
    default = "observability_key_pair"
    description = "Key_pair for Observability Server "
}
variable "instance_type" {
    type = string
    default = "t2.large"
    description = "Instance type of  Observability Server"

}

variable "ssh_key_path" {
    type = string
    default = "/home/ubuntu/ansible/keys/observability_key_pair"
    description = "Key path for the key"
}
variable "vol_size" {
    type = number
    default = 30
    description = "Root block vol size" 
}

variable "vol_type" {
    type = string
    default = "gp3"
    description = "Root block vol type"
}


variable "instance" {
    description = "Observability Instance Details"
    type = map(object({
        ami = string
        instance_type = string
        user = string
        os_family = string
    }))
    default = {
        observability_instance = {
         ami = "ami-02167eae61967e403"
         instance_type = "t2.large"
         user = "ubuntu"
         os_family = "Debian"
    }
    }
    
      }