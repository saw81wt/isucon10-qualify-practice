resource "aws_subnet" "public" {
  vpc_id = var.vpc_id
  cidr_block = format("%s/24", var.vpc_net_mask)
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-1a"
}

resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public.id
  route_table_id = var.route_table_id
}
