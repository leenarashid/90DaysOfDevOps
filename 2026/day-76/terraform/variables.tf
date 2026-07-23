variable "aws_region" {
    description= "AWS Region for Observability Server"
    type = string
    default = "us-west-2"
}
variable "instance_type" {
 description= "Instance type for Observability Server"
    type = string
    default = "t2.large"
   
}
variable "ssh_key_path" {
    description= "SSH Keypath for Observability Server"
    type = string
    default = "/home/ubuntu/otel-keypair"
}

variable "volume_size" {
    description = "Volume size for Observability Server"
    type = number 
    default = 20
}
variable "volume_type"{
    description = "Volume type for Observability Server"
    type = string
    default = "gp3" 
}

variable "project_name" {
    description = "Project name for Observability Server"
    type = string
    default = "Observaability-Task-76"
}
variable "aws_instance" {
    description= "Instance details for Observability Server"
    type = map(object({
        ami = string
        user = string
        os_family = string
        instance_type = string
}))
    default = {
        observability_server ={
            ami = "ami-02167eae61967e403"   
            user = "ubuntu"
            os_family= "Debian"
            instance_type= "t2.large"
        }
        
    }
}

