# Task Definition

resource "aws_ecs_task_definition" "aws-ecs-task" {
  family = "finance-task"

  container_definitions = <<EOF
  [
    {
      "name": "finance-container",
      "image": "suborna/finance_app:v7",
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/finance-logs",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "ecs"
        }
      },
      "portMappings": [
        {
          "containerPort": 5000
        }
      ],
      "environment":[
         {
            "name":"MYSQL_USER",
            "value": "${aws_db_instance.rds_instance.username}"
         },
         {
            "name":"MYSQL_PASSWORD",
            "value": "${aws_db_instance.rds_instance.password}"
         },
         {
            "name":"MYSQL_ENDPOINT",
            "value": "${aws_db_instance.rds_instance.endpoint}"
         },
         {
            "name":"MYSQL_DATABASE",
            "value": "${aws_db_instance.rds_instance.db_name}"
         },
         {
            "name":"FLASK_APP",
            "value": "application"
         },
         {
            "name":"APP_PORT",
            "value": "5000"
         }
      ]
    },
    {
      "name": "datadog-agent",
      "image": "datadog/agent:latest",
      "environment": [
        {
          "name": "DD_API_KEY",
          "value": "f14a419f4854b57b3f626865c2ae12763f2cfa31"
        },
        {
          "name": "ECS_FARGATE",
          "value": "true"
        }
      ]
    }
  ]
  EOF

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "1024"
  cpu                      = "512"
  execution_role_arn       = "arn:aws:iam::309482056010:role/ECS_task_role"
  task_role_arn            = "arn:aws:iam::309482056010:role/ECS_task_role"

}
