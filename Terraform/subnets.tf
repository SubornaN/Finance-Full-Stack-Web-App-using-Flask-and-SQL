resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = "172.38.0.0/18"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "public | us-east-1a"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = "172.38.64.0/18"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "private | us-east-1a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = "172.38.128.0/18"
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "public | us-east-1b"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = "172.38.192.0/18"
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "private | us-east-1b"
  }
}
