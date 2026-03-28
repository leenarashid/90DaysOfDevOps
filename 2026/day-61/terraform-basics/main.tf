# Terraform Block

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

#Provider Block

provider "aws" {
  region = "us-west-2"
}

# resource block (S3-bucket creation)

resource "aws_s3_bucket" "bucket" {
  bucket = "my-tws-bucket-2k26"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

# aws-instance 
resource "aws_instance" "instance" {
  ami           = "ami-04766ae9172186857"
  instance_type = "t2.micro"

  tags = {
    Name = "TerraWeek-Modified"
  }
}
