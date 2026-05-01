output "ec2_instance_id"{
    value = aws_instance.my_instance.id
}

output "ec2_instance_private_ip"{
    value =  aws_instance.my_instance.private_ip
}

output "ec2_instance_id_public_ip"{
    value =  aws_instance.my_instance.public_ip
}