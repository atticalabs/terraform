resource "aws_ecr_repository" "ecr" {
  name = "${var.env_full_name}-${var.image_name}-${var.system_name}"
}