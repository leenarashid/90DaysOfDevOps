output "web_server_ip" {
  value = module.web_server.ec2_instance_id_public_ip
}

output "api_server_ip" {
  value = module.api_server.ec2_instance_id_public_ip
}