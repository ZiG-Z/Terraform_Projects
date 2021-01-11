#ElasticIP

resource "aws_eip" "nat-eip" {
  vpc = true
}

#NAT

resource "aws_nat_gateway" "vpc01-nat" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.vpc01-a-public.id
  depends_on    = [aws_internet_gateway.vpc01-igw]
  tags = {
    "Name" = "vpc01-nat"
  }
}

#PrivateRouteTable

resource "aws_route_table" "vpc01-private" {
  vpc_id = aws_vpc.vpc01.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.vpc01-nat.id
  }
  tags = {
    "Name" = "vpc01-private"
  }
}

#PrivateRouteAssociation

resource "aws_route_table_association" "vpc01-private-asso" {
  subnet_id      = aws_subnet.vpc01-b-private.id
  route_table_id = aws_route_table.vpc01-private.id
}

resource "aws_route_table_association" "vpc01-private-asso1" {
  subnet_id      = aws_subnet.vpc01-c-private.id
  route_table_id = aws_route_table.vpc01-private.id
}