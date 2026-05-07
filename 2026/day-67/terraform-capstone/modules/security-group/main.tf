# resource "aws_vpc" "main" {
#   cidr_block = var.cidr
# tags ={
#      Name  = "${var.project_name}-${var.environment}-TerraWeek-VPC"
# }

#WE DONOT NEED VPC HERE SINCE IT WILL BREAK THE MODULAR DESIGN, VPC IS ONLY SUPPOSED TO BE IN VPC.


resource "aws_security_group" "my_sg" {
  # name = var.security_group_name             no need
  name = "${var.project_name}-${var.environment}-sg"
  vpc_id = var.vpc_id
  
  # dynamic block 
  dynamic "ingress" {
    for_each = var.ingress_ports
    iterator = ingress     #ADDED this 
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
   tags = {

    Name = "${var.project_name}-${var.environment}-TerraWeek-sg"
}
}
