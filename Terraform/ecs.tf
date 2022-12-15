# Cluster
resource "aws_ecs_cluster" "aws-ecs-cluster" {
  name = "financeapp-cluster"
  tags = {
    Name = "finance-ecs"
  }
}