resource "aws_instance" "my_instance" {
        for_each = var.instance 
        key_name = aws_key_pair.my_key_pair.key_name
        ami = each.value.ami 
        vpc_security_group_ids = [aws_security_group.my_sg.id]
        instance_type = var.instance_type 
        
        root_block_device {
          volume_size = var.vol_size
          volume_type = var.vol_type   
        }
        tags = {
            Name = each.key
            user = each.value.user
            os_family = each.value.os_family
            Poject = "Observability_Task"
        }
    

    depends_on = [ aws_security_group.my_sg , aws_key_pair.my_key_pair ]

}   