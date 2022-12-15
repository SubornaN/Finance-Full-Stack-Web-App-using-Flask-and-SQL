# create db subnet group
resource "aws_db_subnet_group" "db_subnet_group" {
  name      = "mysql-db-subnet-group"
  subnet_ids = [
    aws_subnet.private_a.id, 
    aws_subnet.private_b.id
    ]

  tags = {
    Name = "flask-mysql-db-subnet"
  }
}