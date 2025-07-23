resource "aws_s3_bucket" "env_bucket" {
  bucket = var.bucket_name
  
  tags = {
    Name = var.bucket_name
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.env_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "template_file" "rails_env" {
  template = file("${path.module}/env/rails-app.env.tpl")

  vars = {
    db_host      = var.db_host
    aws_region   = var.aws_region
    lb_endpoint  = var.lb_endpoint
    db_name      = var.db_name
    db_username  = var.db_username
    db_password  = var.db_password
  }
}

resource "aws_s3_object" "env_file" {
  bucket  = aws_s3_bucket.env_bucket.id
  key     = var.env_s3_key
  content = data.template_file.rails_env.rendered
  
  tags = {
    Name = "rails-app-env-file"
  }
}