data "aws_ecs_task_definition" "app" {
  task_definition = aws_ecs_task_definition.app.family
}

data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}
resource "aws_ecs_task_definition" "app" {

  family                = "app"
  execution_role_arn    = data.aws_iam_role.ecs_task_execution_role.arn
  container_definitions = <<DEFINITION
[
  {
    "name": "app",
    "image": "account-id.dkr.ecr.aws-region.amazonaws.com/ecr-repo:tagnum",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 5000,
        "hostPort": 5000
      }
    ],
    "memory": 100,
    "cpu": 10
  }
]
DEFINITION
  tags = {
    Name = "APP ECS Service Task Definition"
  }
}
