# VARIABLES
variable "aws_access_key" {}
variable "aws_secret_key" {}
 
# PROVIDER
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "us-east-1"
 
}

#CREATING VPC
resource "aws_vpc" "finance-vpc" {
  cidr_block           = "172.18.0.0/16"
  enable_dns_hostnames = "true"
 
  tags = {
    "Name" : "FinanceVPC"
  }
}

#INSTANCES
resource "aws_instance" "Web_Server" {
  ami                    = "ami-08c40ec9ead489470"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.web_ssh.id]
  user_data = "${file("deploy.sh")}"
  
  key_name = "ssh1"
 
  tags = {
    "Name" : "Web_Server"
  }
}


#Change key_name for the actual deployment!
resource "aws_instance" "MySQL_Server" {
  ami                    = "ami-08c40ec9ead489470"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.database_sg.id]
 
  key_name = "ssh1"
 
  tags = {
    "Name" : "MySQL_Server"
  }
 
    user_data = <<EOF
    #!/bin/sh
    sudo apt update
    sudo apt install mysql-client-core-8.0   
    EOF
    }

# SUBNET 1
resource "aws_subnet" "subnet1" {
  cidr_block              = "172.18.0.0/18"
  vpc_id                  = aws_vpc.finance-vpc.id
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[0]
}

# SUBNET 2
resource "aws_subnet" "pri_subnet1" {
  cidr_block              = "172.18.64.0/18"
  vpc_id                  = aws_vpc.finance-vpc.id
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.available.names[0]
}

#SUBNET 3
resource "aws_subnet" "subnet2" {
  cidr_block              = "172.18.128.0/18"
  vpc_id                  = aws_vpc.finance-vpc.id
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[1]
}

# SUBNET 4
resource "aws_subnet" "pri_subnet2" {
  cidr_block              = "172.18.192.0/18"
  vpc_id                  = aws_vpc.finance-vpc.id
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.available.names[1]
}


# INTERNET GATEWAY
resource "aws_internet_gateway" "gw_1" {
  vpc_id = aws_vpc.finance-vpc.id
}
 
# ROUTE TABLE
resource "aws_route_table" "route_table1" {
  vpc_id = aws_vpc.finance-vpc.id
 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_1.id
  }
}

resource "aws_route_table_association" "route-subnet1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table1.id
}

resource "aws_db_instance" "financedb" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0.28"
  instance_class         = "db.t2.micro"
  db_name                = "financedb"
  username               = "admin"
  password               = "Password123!"
  parameter_group_name   = "default.mysql8.0"
  port                   = 3306
  availability_zone      = "us-east-1a"
  db_subnet_group_name   = aws_db_subnet_group.mysql_subnet_group.id
  vpc_security_group_ids = [aws_security_group.database_sg.id]
  publicly_accessible    = false
  skip_final_snapshot    = true
}

resource "aws_db_subnet_group" "mysql_subnet_group" {
    name = "mysqlsubnetgroup"
    subnet_ids = [aws_subnet.pri_subnet1.id,aws_subnet.pri_subnet2.id]
}

# DATA
data "aws_availability_zones" "available" {
  state = "available"
}

