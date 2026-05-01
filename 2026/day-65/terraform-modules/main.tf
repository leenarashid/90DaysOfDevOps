data "aws_ami" "ubuntu" {
  most_recent      = true
  owners           = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    
  }

}

#==========VPC setup used for TASK4===================
# resource "aws_vpc" "main" {
#   cidr_block = "10.0.0.0/16"

#   tags = {
#     Name = "TerraWeek-VPC"
#   }
# }

# #Subnet
# resource "aws_subnet" "main" {
#   vpc_id     = aws_vpc.main.id
#   cidr_block = "10.0.1.0/24"
#   map_public_ip_on_launch = true


#   tags = {
#     Name = "TerraWeek-Public-Subnet"
#   }
# }
# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.main.id
#   tags = {
#     Name = "TerraWeek-igw"
#     Project = "TerraWeek"
#     Environment = "dev"
#   }
# }

# resource "aws_route_table" "public_rt" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }
#   tags = {
#     Name = "TerraWeek-RT"
#     Project = "TerraWeek"
#     Environment = "dev"
#   }
# }
# resource "aws_route_table_association" "public_assoc" {
#   subnet_id      = aws_subnet.main.id
#   route_table_id = aws_route_table.public_rt.id
# }


#==========================================================#
#========PUBLIC REGISTRY VPC SETUP===============#

resource "aws_key_pair" "main" {
  key_name   = "Terra_Week_key_pair_65"
  public_key = file("terra-automate-key.pub")
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  #version = "~> 5.0"
  #version = "5.1.0"
  version = ">= 5.0, < 6.0"

  name = "terraweek-PR-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway = false
  enable_dns_hostnames = true

  tags = local.common_tags
}
#========================================================#





#Defining locals for common tags and the respective tags

locals {
    common_tags ={
        Project = "PR-terraform-projecr"
        Environment = "dev-PR"
    }
    web_sg_tags = {
        Role = "web-security_group"
    }
    web_server_tags = {
        Role = "web-server"
    }
    api_server_tags = {
        Role = "api-server" 
    }
}
module "web_sg" {
  source        = "./modules/security-group"
  #ec2_instance_vpc_id        = aws_vpc.main.id
  ec2_instance_vpc_id = module.vpc.vpc_id
  ec2_instance_security_group_name = "PR-Web-sg"
  ec2_instance_ingress_ports = [22, 80, 443]
  ec2_instance_sg_tags = merge(
    local.common_tags,
    local.web_sg_tags
  )
}



module "web_server" {
  source             = "./modules/ec2-instance"
  ec2_instance_ami_id  = data.aws_ami.ubuntu.id
  ec2_instance_type     = "t2.micro"
 # ec2_subnet_id          = aws_subnet.main.id
  ec2_subnet_id = module.vpc.public_subnets[0]
  ec2_security_group_ids = [module.web_sg.ec2_sg_id]
  ec2_instance_name   = "PR-Web-Server"
  key_name = aws_key_pair.main.key_name
  ec2_instance_tags = merge(
    local.common_tags,
    local.web_server_tags
  )
}

module "api_server" {
  source             = "./modules/ec2-instance"
  ec2_instance_ami_id            = data.aws_ami.ubuntu.id
  ec2_instance_type      = "t3.micro"
  #ec2_subnet_id        = aws_subnet.main.id
  ec2_subnet_id = module.vpc.public_subnets[0]
  ec2_security_group_ids = [module.web_sg.ec2_sg_id]
  ec2_instance_name      = "PR-Api-Server"
  key_name = aws_key_pair.main.key_name   
   ec2_instance_tags = merge(
    local.common_tags,
    local.api_server_tags
  )
}