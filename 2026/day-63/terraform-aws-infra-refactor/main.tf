#local block
locals {
  name_prefix = "${var.project_name}-${var.environment}"
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

#data-block

data "aws_ami" "amzlinux2" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}

#data-block

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true  #use public dns as it is inside the vpc and it gives the instance public dns. 
  enable_dns_support = true
 # tags = {
   # Name = "${var.environment}-${var.project_name}-VPC"
   tags = merge(local.common_tags, {
      Name = "${local.name_prefix}-vpc"
})

  }


#Subnet
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  # tags = {
  #   Name = "${var.environment}-${var.project_name}-Public-Subnet"
  # }

 tags = merge(local.common_tags, {
      Name = "${local.name_prefix}-subnet"

})
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.environment}-${var.project_name}-igw"
  }
}
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.environment}-${var.project_name}-Public-rt"
  }
}

resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.main.id # must add this id
  ingress {
    from_port   = var.allowed_ports[0]
    to_port     = var.allowed_ports[0]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.allowed_ports[1]
    to_port     = var.allowed_ports[1]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.allowed_ports[2]
    to_port     = var.allowed_ports[2]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.environment}-${var.project_name}-sg"
  }
}

resource "aws_instance" "my_instance" {
  #ami                         = "ami-0d76b909de1a0595d"
  ami                         = data.aws_ami.amzlinux2.id
  #instance_type               = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.main.id
  key_name                    = var.instance_keyname
  instance_type = var.environment == "prod" ? "t3.small" : "t2.micro"
  lifecycle {
    create_before_destroy = true
  }
  # tags = {
  #   Name = "${var.environment}-${var.project_name}-Server"
  # }

 tags = merge(local.common_tags, {
      Name = "${local.name_prefix}-server"

})
}

# resource "aws_s3_bucket" "my_bucket" {
#   bucket     = "terraweek-app-logs-2026"
#   depends_on = [aws_instance.my_instance]
#   tags = {
#     Name = "Terraweek-bucket"

#   }
# }


