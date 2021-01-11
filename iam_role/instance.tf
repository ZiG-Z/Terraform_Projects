resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file(var.public_key)
}


resource "aws_instance" "Web01" {
  ami                    = lookup(var.amis, var.region)
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Public.id]
  availability_zone      = "ap-southeast-1a"
  key_name               = aws_key_pair.mykey.key_name
  tags = {
    "Name" = "Web01"
  }
  iam_instance_profile = aws_iam_instance_profile.s3-mybkt-role-instanceprofile.name
}

resource "aws_security_group" "Public" {
  name        = "Public"
  description = "Public"
  vpc_id      = aws_default_vpc.main.id
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
}
