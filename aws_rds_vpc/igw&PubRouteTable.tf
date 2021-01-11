#InternetGateway

resource "aws_internet_gateway" "vpc01-igw" {
  vpc_id = aws_vpc.vpc01.id
  tags = {
    Name = "vpc01-igw"
  }
}

#PublicRouteTable

resource "aws_route_table" "vpc01-public" {
  vpc_id = aws_vpc.vpc01.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc01-igw.id
  }
  tags = {
    Name = "vpc01-public"
  }
}

#PublicRouteAssociation

resource "aws_route_table_association" "vpc01-public-asso" {
  subnet_id      = aws_subnet.vpc01-a-public.id
  route_table_id = aws_route_table.vpc01-public.id
}