resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "TerraWeek-VPC"
  }
}

#Subnet
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "TerraWeek-Public-Subnet"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "TerraWeek-IGW"
  }
}
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "TerraWeek-RT"
  }
}

resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.main.id # must add this id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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
    Name = "TerraWeek-SG"
  }
}

resource "aws_instance" "my_instance" {
  #ami                         = "ami-0d76b909de1a0595d"
  ami                         = "ami-04766ae9172186857"
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.main.id
  key_name                    = "tf-key"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "TerraWeek-Server"
  }
}
# resource "aws_s3_bucket" "my_bucket" {
#   bucket     = "terraweek-app-logs-2026"
#   depends_on = [aws_instance.my_instance]
#   tags = {
#     Name = "Terraweek-bucket"

#   }
# }
