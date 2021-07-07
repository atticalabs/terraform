module "cloudwatch" {
  source = "../../Modules/CloudWatch"

  environment      = var.environment
  env_full_name    = var.env_full_name
  application_name = var.application_name


}

module "networking" {
  source = "../../Modules/Networking"

  environment   = var.environment
  env_full_name = var.env_full_name
  region        = var.region
  prefix        = var.prefix
}

module "ecs_cluster" {
  source = "../../Modules/ecs"

  env_full_name = var.env_full_name

  environment  = var.environment
  ssh_key_file = var.key_file

  subnet_ids = module.networking.public_subnet_ids
  security_group_ids = concat(
    [],
  [])

  log_group = module.cloudwatch.log_group

  image_id      = var.image_id
  instance_type = var.instance_type
  vpc_id        = module.networking.vpc_id

}

module "runner" {
  source = "../../Modules/EC2"

  env_full_name = "runner_${var.env_full_name}"

  instance_name  = var.runner_instance_name
  instance_type  = var.runner_instance_type
  ami_id         = var.runner_image_id
  ssh_key_file   = var.runner_key_file
  instance_count = var.runner_count

}