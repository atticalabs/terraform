resource "aws_s3_bucket" "bucket" {
  acl    = var.acl
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.env_name
  }

}