 
resource "aws_ecs_task_definition" "kuma_task" {
  family                   = "kuma-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "uptime-kuma"
      image     = "970547338716.dkr.ecr.us-east-1.amazonaws.com/uptime-kuma:latest"
      essential = true
      portMappings = [
        {
          containerPort = 3001
          hostPort      = 3001
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "kuma_service" {
  name            = "kuma-service"
  cluster         = aws_ecs_cluster.kuma_cluster.id
  task_definition = aws_ecs_task_definition.kuma_task.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = aws_subnet.public[*].id
    assign_public_ip = true
    security_groups  = [aws_security_group.allow_http.id]
  }
}
