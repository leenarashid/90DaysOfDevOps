resource "aws_instance" "prometheus_server" {
    for_each = var.instance 

    key_name = aws_key_pair.server_key_pair.key_name
    vpc_security_group_ids = [aws_security_group.server_sg.id]
    ami = each.value.ami
    instance_type = each.value.instance_type

    root_block_device {
          volume_size = var.volume_size
          volume_type = var.volume_type
     
    }
   tags = {
    Name = each.key
    Project = "Task-74"
   }


   depends_on = [aws_key_pair.server_key_pair , aws_security_group.server_sg]
}