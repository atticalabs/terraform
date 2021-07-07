locals {

  // Shared configs 
  application_name = "********************"
  prefix           = "********************"
  environment      = "staging"

  availability_zones = ["${var.region}a", "${var.region}b"]
  env_full_name      = "${local.prefix}-${local.environment}"

  //Runner config
  runner_image_id      = "ami-005425225a11a4777"
  runner_instance_type = "t2.small"
  runner_instance_name = "GitLab_runner"
  runner_key_file      = "../../SSH_Keys/runner_key.pub"
  runner_count         = 0

  key_file = "../../SSH_Keys/********************_dev.pub"

  //API specific config

  //EC2 Config
  api_image_id      = "ami-005425225a11a4777"
  api_instance_type = "t2.small"

  //ECS Task definition config
  api_task_definition_network_mode = "bridge"

  //ECS service config
  api_service_launch_type = "EC2"
  api_service_tasks_count = 1

  //API Load balancer config 
  api_load_balancer_container_name      = "api"
  api_load_balancer_container_port      = 3000
  api_load_balancer_protcol             = "HTTP"
  api_target_group_registration_port    = 80
  api_target_group_registration_potocol = "HTTP"
  api_load_balancer_certificate_arn     = "********************"

  

  //ECS Auto Scaling  config
  api_autoscaling_max_capacity = 1
  api_autoscaling_min_capacity = 1

  //Front Specific config
  //EC2 Config
  front_image_id      = "ami-0c95b81c98a196de2"
  front_instance_type = "t2.medium"

  //ECS Task definition config
  front_task_definition_network_mode = "bridge"

  //ECS service config
  front_service_launch_type = "EC2"
  front_service_tasks_count = 1

  //API Load balancer config 
  front_load_balancer_container_name      = "front"
  front_load_balancer_container_port      = 80
  front_load_balancer_protcol             = "HTTP"
  front_target_group_registration_port    = 80
  front_target_group_registration_potocol = "HTTP"
  front_load_balancer_certificate_arn     = "**************************"

  //ECS Auto Scaling  config
  front_autoscaling_min_capacity = 1
  front_autoscaling_max_capacity = 1

}

module "shared" {
  source = "./../../Systems/Shared"

  environment   = local.environment
  env_full_name = local.env_full_name
  region        = var.region
  prefix        = local.prefix

  application_name = local.application_name
  key_file         = local.key_file
  image_id         = local.api_image_id
  instance_type    = local.api_instance_type

  runner_image_id      = local.runner_image_id
  runner_instance_type = local.runner_instance_type
  runner_instance_name = local.runner_instance_name

  runner_key_file = local.runner_key_file
  runner_count    = local.runner_count

}

module "api" {
  source = "./../../Systems/API"

  application_name = local.application_name
  environment      = local.environment
  region           = var.region
  env_name         = local.environment
  env_full_name    = local.env_full_name
  prefix           = local.prefix

  cluster_id   = module.shared.cluster_id
  cluster_name = module.shared.cluster_name

  service_tasks_count = local.api_service_tasks_count
  service_launch_type = local.api_service_launch_type

  task_definition_network_mode = local.api_task_definition_network_mode

  api_container_definition_file = "${path.module}/variables/api_container__definition.tpl"
  api_settings_file             = "${path.module}/variables/api_settings.json"

  log_group = module.shared.log_group

  api_load_balancer_container_name      = local.api_load_balancer_container_name
  api_load_balancer_container_port      = local.api_load_balancer_container_port
  api_load_balancer_protcol             = local.api_load_balancer_protcol
  api_target_group_registration_port    = local.api_target_group_registration_port
  api_target_group_registration_potocol = local.api_target_group_registration_potocol
  load_balancer_certificate_arn         = local.api_load_balancer_certificate_arn

  vpc_id                       = module.shared.vpc_id
  subnet_ids                   = module.shared.public_subnet_ids
  security_group_ids           = module.shared.security_group_ids
  ecs_inbound_sg               = module.shared.ecs_inbound_sg
  app_autoscaling_min_capacity = local.api_autoscaling_min_capacity
  app_autoscaling_max_capacity = local.api_autoscaling_max_capacity

}

module "front" {
  source = "./../../Systems/Front"

  application_name = local.application_name
  environment      = local.environment
  region           = var.region
  env_name         = local.environment
  env_full_name    = local.env_full_name
  prefix           = local.prefix

  cluster_id   = module.shared.cluster_id
  cluster_name = module.shared.cluster_name

  service_tasks_count = local.front_service_tasks_count
  service_launch_type = local.front_service_launch_type

  task_definition_network_mode = local.front_task_definition_network_mode

  container_definition_file = "${path.module}/variables/front_containter_definition.tpl"
  settings_file             = "${path.module}/variables/front_settings.json"

  log_group = module.shared.log_group

  load_balancer_container_name      = local.front_load_balancer_container_name
  load_balancer_container_port      = local.front_load_balancer_container_port
  load_balancer_protcol             = local.front_load_balancer_protcol
  target_group_registration_potocol = local.front_target_group_registration_potocol
  target_group_registration_port    = local.front_target_group_registration_port

  vpc_id             = module.shared.vpc_id
  subnet_ids         = module.shared.public_subnet_ids
  security_group_ids = module.shared.security_group_ids
  ecs_inbound_sg     = module.shared.ecs_inbound_sg

  app_autoscaling_min_capacity = local.front_autoscaling_min_capacity
  app_autoscaling_max_capacity = local.front_autoscaling_max_capacity

  load_balancer_certificate_arn = local.front_load_balancer_certificate_arn
} 