resource "aws_cloudwatch_log_group" "log_group" {
  name = var.env_full_name

  tags = {
    Environment = var.environment
    Application = var.application_name
  }
}

