resource "aws_security_group" "myalb" {
  name        = "ALB"
  description = "ALB"
  vpc_id      = aws_vpc.vpc01.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
  ingress {
    ipv6_cidr_blocks = ["::/0"]
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
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

resource "aws_security_group" "Public" {
  name        = "Public"
  description = "Public"
  vpc_id      = aws_vpc.vpc01.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
  ingress {
    ipv6_cidr_blocks = ["::/0"]
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  ingress {
    ipv6_cidr_blocks = ["::/0"]
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
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