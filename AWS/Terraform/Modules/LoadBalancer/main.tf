
resource "random_id" "target_group_sufix" {
  byte_length = 1
}

resource "aws_alb_target_group" "alb_target_group" {
  name                 = "${var.service_full_name}-tgp-${random_id.target_group_sufix.hex}"
  port                 = var.target_group_registration_port
  protocol             = var.target_group_registration_potocol
  vpc_id               = var.vpc_id
  target_type          = "instance"
  deregistration_delay = 10

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200,301,302"
  }

}

resource "aws_alb" "app" {
  name    = "${var.service_full_name}-alb"
  subnets = var.subnet_ids
  security_groups = concat(
    var.security_group_ids,
    [
      var.ecs_inbound_sg
    ],
  )

  tags = {
    Name        = "${var.service_full_name}-alb"
    Environment = var.environment
  }
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_alb.app.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_alb.app.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_target_group.arn
  }
}