
resource "aws_ecs_cluster" "ecs-cluster" {
  name = "devops-case-cluster"
}

resource "aws_ecs_service" "main" {
  name                   = "devops-case-service"
  cluster                = aws_ecs_cluster.ecs-cluster.id
  launch_type            = "FARGATE"
  enable_execute_command = true

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  desired_count                      = 1
  task_definition                    = aws_ecs_task_definition.td.arn

  network_configuration {
    security_groups  = [aws_security_group.sg.id]
    subnets          = [aws_subnet.sn1.id, aws_subnet.sn2.id, aws_subnet.sn3.id]
    assign_public_ip = true
  }


}

resource "aws_ecs_task_definition" "td" {
  container_definitions = jsonencode([
    {
      name   = "devops-case-app-fm"
      image  = "710449245738.dkr.ecr.us-east-1.amazonaws.com/devops-case"
      cpu    = 256
      memory = 512
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])

  family                   = "devops-case-app-fm"
  requires_compatibilities = ["FARGATE"]

  cpu                = "256"
  memory             = "512"
  network_mode       = "awsvpc"
  task_role_arn      = "arn:aws:iam::710449245738:role/ecsTaskExecutionRole"
  execution_role_arn = "arn:aws:iam::710449245738:role/ecsTaskExecutionRole"
}
