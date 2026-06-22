resource "aws_instance" "my_instance" {
    for_each =  var.instances 
      ami = each.value.ami
      instance_type = var.instance_type ###since instance_type is defined as a separate variable
      vpc_security_group_ids = [aws_security_group.ansible-sg-71.id] #####not ids
      key_name = aws_key_pair.ansible_key_pair.key_name

      root_block_device {
        volume_size = var.volume_size
        volume_type = var.volume_type
      }
      tags ={
        Name = each.key
        os_family = each.value.os_family
        Managed_by = "Terraform"
        Task = "Day-71" 

      }
      depends_on = [aws_security_group.ansible-sg-71, aws_key_pair.ansible_key_pair]

}