output "instance_details"{
    value = {
        for name, instance in aws_instance.my_instance :
    name => {
    public_ip =instance.public_ip
      
    public_dns = instance.public_dns   
}
    }
}