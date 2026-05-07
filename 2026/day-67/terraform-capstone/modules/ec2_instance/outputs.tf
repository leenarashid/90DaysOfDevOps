output instance_id {
    value = aws_instance.my_instance.id
} 

output public_ip {
    value = aws_instance.my_instance.public_ip
}
output "instance_type" {
  value = aws_instance.my_instance.instance_type
}
output "availability_zone" {
  value = aws_instance.my_instance.availability_zone
}

output "instance_name" {
  value = aws_instance.my_instance.tags["Name"]
}