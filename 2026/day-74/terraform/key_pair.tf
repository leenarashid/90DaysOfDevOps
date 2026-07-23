resource "aws_key_pair" "server_key_pair" {
    key_name = "server_key"
    public_key = file("server_key.pub")

}