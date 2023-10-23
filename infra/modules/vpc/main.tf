resource "aws_vpc" "isucon" {
  cidr_block = format("%s/16", var.vpc_net_mask)
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "isucon"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.isucon.id
}

resource "aws_internet_gateway" "isucon" {
  vpc_id = aws_vpc.isucon.id
}

resource "aws_route" "public_dns" {
  route_table_id = aws_route_table.public.id
  gateway_id = aws_internet_gateway.isucon.id
  destination_cidr_block = "0.0.0.0/0"
}

