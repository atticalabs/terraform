resource "aws_cloudwatch_dashboard" "cloudwatch_dashboard" {
  dashboard_name = var.service_full_name
  dashboard_body = templatefile("${path.module}/templates/dashboard_body.tpl", {
    alb_name     = var.alb_arn_suffix
    region       = var.region
    cluster_name = var.cluster_name
  })
}

