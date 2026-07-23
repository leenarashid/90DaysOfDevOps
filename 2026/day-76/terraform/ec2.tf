resource "aws_instance" "my_instance" {
    for_each = var.aws_instance 
    
    ami = each.value.ami
    key_name = aws_key_pair.my-keypair.key_name
    instance_type =  var.instance_type
    vpc_security_group_ids = [aws_security_group.my_sg_77.id]
    

    root_block_device {
 
       volume_type = var.volume_type
       volume_size = var.volume_size
    
    }
    tags = {
        Name = each.key
        os_family = each.value.os_family
        user = each.value.user
        Project =  var.project_name
    }
    depends_on = [aws_security_group.my_sg_77, aws_key_pair.my-keypair]
}