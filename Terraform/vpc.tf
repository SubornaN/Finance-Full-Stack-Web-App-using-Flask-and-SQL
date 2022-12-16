# VPC
resource "aws_vpc" "app_vpc" {
  cidr_block = "172.28.0.0/16"

  tags = {
    Name = "flask-docker-vpc"
  }
}

resource "aws_eip" "elastic-ip" {
  vpc = true
}

resource "aws_nat_gateway" "ngw" {
  subnet_id     = aws_subnet.public_a.id
  allocation_id = aws_eip.elastic-ip.id
}
