locals {
  system_name = "api"

  service_full_name = "${var.prefix}-${var.env_name}-${local.system_name}"

  api_enviroment_keys = jsondecode(file(var.api_settings_file))
}

module "ecr" {
  source = "../../modules/ECR"

  system_name   = local.system_name
  image_name    = local.service_full_name
  env_full_name = var.env_full_name

}

data "template_file" "_api_environment_keys" {
  count = length(keys(local.api_enviroment_keys))

  template = <<JSON
{
  "name": $${name},
  "value":$${value}
}
JSON


  vars = {
    name = jsonencode(element(keys(local.api_enviroment_keys), count.index))
    value = jsonencode(
      local.api_enviroment_keys[element(keys(local.api_enviroment_keys), count.index)],
    )
  }
}

module "ecs_service_task" {
  source = "../../modules/ECS_service_task_definitions"

  system_name       = local.system_name
  env_name          = var.env_name
  service_full_name = local.service_full_name

  cluster_id   = var.cluster_id
  cluster_name = var.cluster_name

  container_definitions = templatefile(var.api_container_definition_file, {
    log_group    = var.log_group,
    region       = var.region,
    app_settings = join(",", data.template_file._api_environment_keys.*.rendered),
    api_image    = module.ecr.repository_url
  })

  task_definition_network_mode = var.task_definition_network_mode
  task_definition_role_arn     = module.ecs_service_role.task_definition_role_arn

  service_tasks_count = var.service_tasks_count
  service_launch_type = var.service_launch_type

  load_balancer_target_group_arn = module.alb.load_balancer_target_group_arn
  load_balancer_container_name   = var.api_load_balancer_container_name
  load_balancer_container_port   = var.api_load_balancer_container_port
}

module "ecs_service_role" {
  source = "../../modules/ECS_service_role"

  service_app_name = local.system_name
  env_full_name    = var.env_full_name

}

module "ecs_auto_scaling" {
  source = "../../modules/AutoScaling"

  ecs_service_name  = module.ecs_service_task.ecs_service_name
  service_full_name = local.service_full_name

  app_autoscaling_max_capacity = var.app_autoscaling_max_capacity
  app_autoscaling_min_capacity = var.app_autoscaling_min_capacity

  cluster_name = var.cluster_name
}

module "alb" {
  source = "../../modules/LoadBalancer"


  service_full_name                 = local.service_full_name
  vpc_id                            = var.vpc_id
  subnet_ids                        = var.subnet_ids
  security_group_ids                = var.security_group_ids
  ecs_inbound_sg                    = var.ecs_inbound_sg
  environment                       = var.environment
  load_balancer_protcol             = var.api_load_balancer_protcol
  target_group_registration_port    = var.api_target_group_registration_port
  target_group_registration_potocol = var.api_target_group_registration_potocol

  certificate_arn = var.load_balancer_certificate_arn
}

module "cloudwatch_dashboard" {
  source = "../../modules/CloudWatch_dashboard"


  region            = var.region
  service_full_name = local.service_full_name
  application_name  = var.application_name

  alb_arn_suffix = module.alb.alb_arn_suffix

  cluster_name = var.cluster_name
}
 