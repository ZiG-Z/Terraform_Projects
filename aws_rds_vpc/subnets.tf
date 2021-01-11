#PublicSubnet

resource "aws_subnet" "vpc01-a-public" {
  vpc_id                  = aws_vpc.vpc01.id
  cidr_block              = "10.10.0.0/20"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "vpc01-a-public"
  }

}

#PrivateSubnet

resource "aws_subnet" "vpc01-b-private" {
  vpc_id                  = aws_vpc.vpc01.id
  cidr_block              = "10.10.16.0/20"
  availability_zone       = "ap-southeast-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "vpc01-b-private"
  }
}

resource "aws_subnet" "vpc01-c-private" {
  vpc_id                  = aws_vpc.vpc01.id
  cidr_block              = "10.10.32.0/20"
  availability_zone       = "ap-southeast-1c"
  map_public_ip_on_launch = false
  tags = {
    Name = "vpc01-c-private"
  }
}