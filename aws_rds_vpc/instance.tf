resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file(var.public_key)
}

resource "aws_instance" "DBClient" {
  ami                    = lookup(var.amis, var.region)
  key_name               = aws_key_pair.mykey.key_name
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.DbClient.id]
  availability_zone      = "ap-southeast-1a"
  subnet_id              = aws_subnet.vpc01-a-public.id

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }

  connection {
    user        = var.instance_username
    host        = self.public_ip
    private_key = file(var.private_key)
  }
}

resource "aws_security_group" "DbClient" {
  name        = "DBClient"
  description = "DBClient"
  vpc_id      = aws_vpc.vpc01.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
  egress {
    ipv6_cidr_blocks = ["::/0"]
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
  }

}