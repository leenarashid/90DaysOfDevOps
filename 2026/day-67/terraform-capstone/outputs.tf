output "instance_id" {
  value = module.ec2_instance.instance_id
}

output "public_ip" {
  value = module.ec2_instance.public_ip
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_id" {
  value = module.vpc.subnet_id
}

output "instance_type" {
  value = module.ec2_instance.instance_type
}

output "availability_zone" {
  value = module.ec2_instance.availability_zone
}
output "instance_name"{
    value = module.ec2_instance.instance_name
}