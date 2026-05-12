resource "aws_key_pair" "my_keypair" {
    key_name = "master-key"
    public_key = file("master-key.pub")
}

resource "aws_default_vpc" "my_vpc" {
    tags = {
        Name = "Ansible_VPC"
    }
}
resource "aws_security_group" "my_sg" {
  name        = "Ansible_sg"
  description = "Allow inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.my_vpc.id

  tags = {
    Name = "Ansible_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.my_sg.id
  cidr_ipv4        = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.my_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.my_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_instance" "my_instance" {
    for_each = var.instances
    key_name = aws_key_pair.my_keypair.key_name
    ami =  each.value.ami
    instance_type = each.value.instance_type
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    root_block_device {
        volume_size = 10
        volume_type = "gp3"
    }
    tags ={
        Name = each.key
        os_family = each.value.os_family
    }
}
