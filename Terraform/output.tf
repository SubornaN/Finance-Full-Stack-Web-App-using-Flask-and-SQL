output "postgres_endpoint" {
  value = aws_db_instance.rds_instance.endpoint
}

output "alb_finance" {
  value = "http://${aws_alb.finance_app.dns_name}"
}
