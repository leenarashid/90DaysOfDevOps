resource "aws_instance" "my_instance" {
    for_each = var.instances
      
        ami = each.value.ami
        instance_type = each.value.instance_type
        key_name = aws_key_pair.ansible_terra_key_pair.key_name
        vpc_security_group_ids = [aws_security_group.ansible_sg.id]
        root_block_device {
            volume_size = var.volume_size
            volume_type = var.volume_type
        }
         tags = {
            Name = each.key   #NO third thing here" 
            user = each.value.user  
            os_family = each.value.os_family
            Project = "Terra-Ansible-Project"

              
            }            
            
          depends_on = [aws_security_group.ansible_sg, aws_key_pair.ansible_terra_key_pair]               
            }

         
      
