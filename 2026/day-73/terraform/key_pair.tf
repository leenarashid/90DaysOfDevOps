resource "aws_key_pair" "my_key_pair" {
    key_name = var.instance_key_pair
    public_key = file("observability_key_pair.pub")
}