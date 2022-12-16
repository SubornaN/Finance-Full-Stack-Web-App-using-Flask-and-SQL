
resource "aws_cloudwatch_log_group" "log-group" {
  name = "/ecs/finance-logs"

  tags = {
    Application = "finance-app"
  }
}
