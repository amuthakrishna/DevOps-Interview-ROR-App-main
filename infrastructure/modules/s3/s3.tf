resource "aws_s3_bucket" "env_file_bucket" {
  bucket = var.env_s3_bucket

  tags = {
    Name        = "env-file-bucket"
    Environment = "dev"
  }
}



resource "aws_s3_object" "env_file" {
  bucket       = aws_s3_bucket.env_file_bucket.id
  key          = var.env_s3_key
  source       = "${path.module}/env/rails-app.env"
  content_type = "text/plain"
}
