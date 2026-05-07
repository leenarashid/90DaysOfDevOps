resource "aws_vpc" "main" {
  cidr_block = var.cidr
tags ={
     Name  = "${var.project_name}-${var.environment}-TerraWeek-VPC"
}
}
resource "aws_subnet" "my_public_subnet" {
  cidr_block              = var.cidr
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = "true"
  availability_zone       = var.availability_zone

  tags = {
    Name = "${var.project_name}-${var.environment}-TerraWeek-public_subnet"
  }
}



resource "aws_internet_gateway" "my_gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-${var.environment}-TerraWeek-gw"
  }
}

resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"   # allow internet access
    gateway_id = aws_internet_gateway.my_gw.id
  }

  tags = {
    Name  = "${var.project_name}-${var.environment}-TerraWeek-rt"
   
  }
}

resource "aws_route_table_association" "rt-association" {
  subnet_id      = aws_subnet.my_public_subnet.id
  route_table_id = aws_route_table.my_rt.id
  
}
















#FOR PRIVATE 
# resource "aws_subnet" "private" {
#   cidr_block              = "10.10.2.0/24"
#   vpc_id                  = aws_vpc.myvpc.id
#   map_public_ip_on_launch = "false"
#   availability_zone = "ap-northeast-1d"

#   tags = {
#     Name = "private"
#   }
# }