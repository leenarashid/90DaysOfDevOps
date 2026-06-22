resource "aws_key_pair" "ansible_key_pair" {
    key_name = var.aws_key_pair
    public_key = file("${path.module}/tf-ansible-key.pub")
}