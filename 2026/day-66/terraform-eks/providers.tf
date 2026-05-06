provider "aws"{
    region = "us-west-2"
}
terraform {
    required_providers {
        aws = {

        source = "hashicorp/aws"
        version = "~> 5.0"
        
        }
         kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    }
}