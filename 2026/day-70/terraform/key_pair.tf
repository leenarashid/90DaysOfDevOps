resource "aws_key_pair" "ansible_terra_key_pair" {
    key_name = var.key_name
    public_key = file ("${path.module}/terraform-ansible-key.pub")
    tags= {
        Name= "Terraform-Ansible-key"
    }
}