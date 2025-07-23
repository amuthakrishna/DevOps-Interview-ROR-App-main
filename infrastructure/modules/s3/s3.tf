resource "aws_s3_bucket" "env_file_bucket" {
  bucket = var.env_s3_bucket

  tags = {
    Name        = "env-file-bucket"
    Environment = "dev"
  }
}

data "template_file" "app_env" {
  template = file("${path.module}/env/rails-app.env")

  vars = {
    db_name        = var.db_name
    db_username    = var.db_username
    db_password    = var.db_password
    db_host        = var.db_host
    s3_bucket_name = var.s3_bucket_name
    aws_region     = var.aws_region
    lb_endpoint    = var.lb_endpoint
  }
}

resource "aws_s3_object" "env_file" {
  bucket       = aws_s3_bucket.env_file_bucket.id
  key          = var.env_s3_key
  content      = data.template_file.app_env.rendered
  content_type = "text/plain"
}
