resource "aws_default_vpc" "main" {
    tags = {
        Nmae = "Ansible_Terraform_VPC"
    }
}
resource "aws_security_group" "ansible_sg"{
    name = "ansible_sg"
    description = "Security group for Ansible"
    vpc_id = aws_default_vpc.main.id
    
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH"
    } 
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP"

    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description ="HTTPS"
    }
    egress  {
        protocol = "-1"
        description = "All outbound traffic"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "Terraform-Ansible-sg"
    }
}