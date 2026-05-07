provider "aws" {
  region = "us-west-2"
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.38.0"
    }
  }
}