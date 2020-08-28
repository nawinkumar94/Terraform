# nat gw
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.main_subnet_public_id_1.id

  tags = {
    Name = "gw NAT"
  }
}

resource "aws_route_table" "main-private" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }
  tags = {
    Name = "main-private"
  }
}

resource "aws_route_table_association" "route_private_a" {
  subnet_id      = aws_subnet.main_subnet_private_id_1.id
  route_table_id = aws_route_table.main-private.id
}
resource "aws_route_table_association" "route_private_b" {
  subnet_id      = aws_subnet.main_subnet_private_id_2.id
  route_table_id = aws_route_table.main-private.id
}
resource "aws_route_table_association" "route_private_c" {
  subnet_id      = aws_subnet.main_subnet_private_id_3.id
  route_table_id = aws_route_table.main-private.id
}
