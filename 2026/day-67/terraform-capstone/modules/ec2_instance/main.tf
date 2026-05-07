
   resource "aws_instance" "my_instance"{
   
    ami = var.ami_id
    instance_type = var.instance_type
    vpc_security_group_ids = var.security_group_ids
    subnet_id = var.subnet_id
    tags =     {                                
    
      Name = "${var.project_name}-${var.environment}-TerraWeek-ec2-instance"
    }
   }  