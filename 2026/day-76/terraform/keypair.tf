resource "aws_key_pair" "my-keypair" {
    public_key = file("otel-77.pub")
    key_name = "otel-77"
}