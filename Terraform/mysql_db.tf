# create the RDS instance
resource "aws_db_instance" "rds_instance" {
  identifier                  = "mysql-db"
  allocated_storage           = 20
  storage_type                = "gp2"
  multi_az                    = false
  engine                      = "mysql"
  engine_version              = "8.0.28"
  instance_class              = "db.t3.micro"
  db_name                     = "financedb"
  username                    = var.rds_username
  password                    = var.rds_password
  port                        = 3306
  vpc_security_group_ids      = [aws_security_group.rds_sg.id, aws_security_group.ingress_app.id]

  parameter_group_name        = "default.mysql8.0"
  db_subnet_group_name        = aws_db_subnet_group.db_subnet_group.name # id
  publicly_accessible         = false # true(if required)
  allow_major_version_upgrade = false
  auto_minor_version_upgrade  = false
  apply_immediately           = true
  storage_encrypted           = false
  skip_final_snapshot         = true
  final_snapshot_identifier   = "worker-final"

  tags = {
    Name = "flask-mysql-rds"
  }
}