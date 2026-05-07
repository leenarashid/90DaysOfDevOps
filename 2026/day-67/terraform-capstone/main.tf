data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]

  }

}






module "vpc" {
  source = "./modules/vpc"

  cidr               = var.cidr
  public_subnet_cidr = var.public_subnet_cidr
  #availability_zone  = var.availability_zone
  availability_zone = var.availability_zone_map[terraform.workspace] #for multi-zone workspaces
  project_name      = var.project_name
  environment       = local.environment
}


module "security_group" {
  source              = "./modules/security-group"
  security_group_name = "${local.name_prefix}-sg"
  vpc_id              = module.vpc.vpc_id #####
  ingress_ports       = var.ingress_ports
  project_name        = var.project_name
  environment         = local.environment
}


module "ec2_instance" {
  source        = "./modules/ec2_instance"
  ami_id        = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  # ec2_subnet_id          = aws_subnet.main.id
  subnet_id          = module.vpc.subnet_id
  security_group_ids = [module.security_group.sg_id]
  #security_group_ids = [module.security_group.security_group_id]
  project_name = var.project_name
  environment  = local.environment

}