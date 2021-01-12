resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file(var.public_key)
}

resource "aws_instance" "Web01" {
  ami                    = lookup(var.amis, var.region)
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.Public.id]
  availability_zone      = "ap-southeast-1a"
  subnet_id              = aws_subnet.vpc01-a-public.id
  user_data              = <<EOF
    #!/bin/bash
    yum install httpd -y
    systemctl start httpd
    systemctl enable httpd
    echo Web01 > /var/www/html/index.html
    systemctl restart httpd
  EOF
  tags = {
    "Name" = "Web01"
  }
}

resource "aws_instance" "Web02" {
  ami                    = lookup(var.amis, var.region)
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.Public.id]
  availability_zone      = "ap-southeast-1b"
  subnet_id              = aws_subnet.vpc01-b-public.id
  user_data              = <<EOF
    #!/bin/bash
    yum install httpd -y
    systemctl start httpd
    systemctl enable httpd
    echo Web02 > /var/www/html/index.html
    systemctl restart httpd
  EOF
  tags = {
    "Name" = "Web02"
  }
}
