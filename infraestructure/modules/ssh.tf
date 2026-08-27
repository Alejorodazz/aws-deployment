resource "aws_key_pair" "server_demo_ssh" {
    key_name = "server_demo_ssh"
    public_key = file("../../../server_demo.key.pub ")
}