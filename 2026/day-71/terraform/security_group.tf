resource "aws_default_vpc" "main" {

}
resource "aws_security_group" "ansible-sg-71" {
  name = "ansible-sg-71"
  description = "Ansible Security Groups "
  vpc_id = aws_default_vpc.main.id

    #SSH
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH"
    }
    #HTTP
    ingress {
        from_port =80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP"
    }
    #HTTPS
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTPS" 
      }
    #All outbound
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "All outbound traffic"
    }  
    tags = {
        Name = "ansible-sg-71"
    }
  

}