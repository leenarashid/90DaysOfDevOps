# resource "aws_default_vpc" "my_vpc" {
#   tags = {
#     Name = "Terra-Week-VPC"
#   }
# }
resource "aws_security_group" "my_sg" {
  name = var.ec2_instance_security_group_name
  vpc_id = var.ec2_instance_vpc_id
  
  # dynamic block 
  dynamic "ingress" {
    for_each = var.ec2_instance_ingress_ports

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
   tags = var.ec2_instance_sg_tags
}