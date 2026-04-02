output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "The Subnet ID"
  value       = aws_subnet.main.id
}
output "instance_id" {
  description = "The EC2 instance ID"
  value       = aws_instance.my_instance.id
}
output "instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.my_instance.public_ip
}

output "instance_public_dns" {
  description = "The public DNS name"
  value       = aws_instance.my_instance.public_dns

}
output "security_group_id" {
  description = "The security group ID"
  value       = aws_security_group.sg.id
}
