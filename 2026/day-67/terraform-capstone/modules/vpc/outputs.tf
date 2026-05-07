output "vpc_id" {

    value = aws_vpc.main.id
}

output "subnet_id"{
    value = aws_subnet.my_public_subnet.id
}
