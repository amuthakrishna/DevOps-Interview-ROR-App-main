resource "aws_s3_bucket" "env_file_bucket" {
  bucket = var.env_s3_bucket

  tags = {
    Name        = "env-file-bucket"
    Environment = "dev"
  }
}


