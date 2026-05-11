resource "aws_key_pair" "my_keypair" {
   key_name = "ansible-master-key"
   public_key = file("ansible-master-key.pub")
   tags = {
    Name = "Ansible-keypair"
   }
}

resource "aws_default_vpc" "my_vpc"{
    tags ={
        Name = "Ansible-VPC"
    }
}

resource "aws_security_group" "my_sg" {
  name        = "allow_tls"
  description = "Allow tls inbound traffic"
  vpc_id      = aws_default_vpc.my_vpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #put cidr block in [],otherwise results in error.
  }



  ingress {
    description = " SSH from VPC"
    from_port   = 22
    to_port     = 22
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
    Name = "Ansible-security_group"
  }
}

resource "aws_instance" "my_instance" {
  for_each = var.instances  
  ami           = each.value.ami
  instance_type = each.value.instance_type
  #instance_state = "running"
  key_name = aws_key_pair.my_keypair.key_name
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  tags = {
    Name = each.key
    os_family = each.value.os_family

  }
}