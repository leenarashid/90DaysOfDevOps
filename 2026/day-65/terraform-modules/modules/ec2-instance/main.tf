# resource "aws_key_pair" "my_key_pair" {
#   key_name   = "terra_week_key_pair"
#   public_key = file("terra-automate-key.pub")
# }
# resource "aws_default_vpc" "my_vpc" {
#   tags = {
#     Name = "Terra-Week-VPC"
#   }
# }
# resource "aws_security_group" "my_sg" {
#   name        = "Terra-Week-sg"
#   description = "Allow TLS inbound traffic and all outbound traffic"
#   vpc_id      = aws_default_vpc.my_vpc.id  #interpolation

#   tags = {
#     Name = "Terra-Week-sg"
#   }
# }

# resource "aws_vpc_security_group_ingress_rule" "allows_http" {
#   security_group_id = aws_security_group.my_sg.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 80
#   ip_protocol       = "tcp"
#   to_port           =  80
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
#   security_group_id = aws_security_group.my_sg.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 22
#   ip_protocol       = "tcp"
#   to_port           =  22
# }

# resource "aws_vpc_security_group_egress_rule" "allows_all_traffic" {
#   security_group_id = aws_security_group.my_sg.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }

resource "aws_instance" "my_instance"{
   
    ami = var.ec2_instance_ami_id
    instance_type = var.ec2_instance_type
    #key_name = aws_key_pair.my_key_pair.key_name
    key_name = var.key_name
    vpc_security_group_ids = var.ec2_security_group_ids
    subnet_id = var.ec2_subnet_id
    tags = merge(                                     #merging of both name and tags
    {
      Name = var.ec2_instance_name
    },
    var.ec2_instance_tags
  )

    root_block_device {
      volume_size = 10
      volume_type = "gp3"
    }
}

#NO NEED AS IT ALREADY ENSURES INSTANCE IS RUNNING
# resource "aws_ec2_instance_state" "my_instance_state" {
#   instance_id = aws_instance.my_instance.id
#   state       = "running"
# }