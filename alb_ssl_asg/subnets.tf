#PublicSubnets

resource "aws_subnet" "vpc01-a-public" {
  cidr_block              = "192.168.0.0/24"
  vpc_id                  = aws_vpc.vpc01.id
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "vpc01-a-public"
  }
}

resource "aws_subnet" "vpc01-b-public" {
  cidr_block              = "192.168.1.0/24"
  vpc_id                  = aws_vpc.vpc01.id
  availability_zone       = "ap-southeast-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "vpc01-b-public"
  }
}

resource "aws_subnet" "vpc01-c-public" {
  cidr_block              = "192.168.2.0/24"
  vpc_id                  = aws_vpc.vpc01.id
  availability_zone       = "ap-southeast-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "vpc01-c-public"
  }
}