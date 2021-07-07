output "alb_arn_suffix" {
  value = aws_alb.app.arn_suffix
}

output "load_balancer_target_group_arn" {
  value = aws_alb_target_group.alb_target_group.arn
}
