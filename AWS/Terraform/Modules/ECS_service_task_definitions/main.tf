resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.service_full_name
  container_definitions    = var.container_definitions
  requires_compatibilities = [var.service_launch_type]
  network_mode             = var.task_definition_network_mode
  execution_role_arn       = var.task_definition_role_arn
  task_role_arn            = var.task_definition_role_arn
}

resource "aws_ecs_service" "service" {
  name            = var.service_full_name
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = var.service_tasks_count
  launch_type     = var.service_launch_type
  cluster         = var.cluster_id

  load_balancer {
    target_group_arn = var.load_balancer_target_group_arn
    container_name   = var.load_balancer_container_name
    container_port   = var.load_balancer_container_port
  }
}