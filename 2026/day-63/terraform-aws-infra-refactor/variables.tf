variable "region" {
  description = "AWS region where resources will be provisioned"
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}
variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "instance_keyname" {
  description = "The keyname of EC2 instance"
  type        = string
  default     = "tf-key"
}


variable "project_name" {
  description = "Name of the project used for tagging and resource naming"
  type        = string

}

variable "environment" {
  description = "Deployment environment (e.g. dev,stg,prd)"
  type        = string
  default     = "dev"

}

variable "allowed_ports" {
  description = "The list of allowed inboound ports"
  type        = list(number)
  default     = [22, 80, 443]
}

variable "extra_tags" {
  description = "Additional tags for resources"
  type        = map(string)
  default     = {}
}
