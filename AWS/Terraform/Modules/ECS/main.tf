locals {
  ecs_min_size         = var.ecs_min_size
  ecs_max_size         = var.ecs_max_size
  ecs_desired_capacity = var.ecs_desired_capacity
}

resource "aws_ecs_cluster" "cluster" {
  name = "${var.env_full_name}-ecs-cluster"
}

resource "aws_key_pair" "key" {
  key_name   = "${var.env_full_name}-key"
  public_key = file(var.ssh_key_file)
}

resource "aws_security_group" "inbound_sg" {
  name        = "${var.env_full_name}-inbound-sg"
  description = "Allow HTTP from Anywhere into ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_full_name}-inbound-sg"
  }
}

resource "aws_autoscaling_group" "ecs_group" {
  name                = "${var.env_full_name}-as-group"
  vpc_zone_identifier = var.subnet_ids

  min_size                  = local.ecs_min_size
  max_size                  = local.ecs_max_size
  desired_capacity          = local.ecs_desired_capacity
  health_check_grace_period = 0
  launch_configuration      = aws_launch_configuration.ec_instance.name

  tag {
    key                 = "Name"
    value               = "${var.env_full_name}-ecs"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }
}

data "template_file" "ecs_linux" {
  template = file("${path.module}/user_data/amzl-user-data.tpl")

  vars = {
    ecs_cluster_name   = aws_ecs_cluster.cluster.name
    ecs_log_group_name = var.log_group
  }
}

resource "aws_iam_instance_profile" "ecs_instance" {
  name = "${var.env_full_name}-ecs-instance-profile"
  role = aws_iam_role.ecs_instance.name
}

data "template_file" "instance_role_trust_policy" {
  template = file("${path.module}/policies/instance-role-trust-policy.json")
}

resource "aws_iam_role" "ecs_instance" {
  name               = "${var.env_full_name}-ecs-instance-role"
  assume_role_policy = data.template_file.instance_role_trust_policy.rendered
}

data "template_file" "instance_profile" {
  template = file("${path.module}/policies/instance-profile-policy.json")
}

resource "aws_iam_role_policy" "ecs_instance" {
  name   = "${var.environment}-ecs-instance-role"
  role   = aws_iam_role.ecs_instance.name
  policy = data.template_file.instance_profile.rendered
}

resource "aws_launch_configuration" "ec_instance" {
  security_groups      = concat(var.security_group_ids, [aws_security_group.inbound_sg.id])
  key_name             = aws_key_pair.key.key_name
  image_id             = var.image_id
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ecs_instance.name
  user_data            = data.template_file.ecs_linux.rendered

  associate_public_ip_address = false

  lifecycle {
    create_before_destroy = true
  }
}

