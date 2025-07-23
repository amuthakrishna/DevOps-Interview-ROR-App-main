

resource "aws_s3_bucket" "env_bucket" {
  bucket = var.bucket_name
  tags = {
    Name = var.bucket_name
  }
}