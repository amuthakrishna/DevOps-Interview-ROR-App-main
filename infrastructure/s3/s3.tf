resource "aws_s3_bucket" "app_storage" {
  bucket = "${var.project_name}-ror"

  tags = {
    Name = "${var.project_name}-ror"
  }
}

resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_s3_bucket_versioning" "app_storage" {
  bucket = aws_s3_bucket.app_storage.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "app_storage" {
  bucket = aws_s3_bucket.app_storage.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "app_storage" {
  bucket = aws_s3_bucket.app_storage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "env_file" {
  bucket = aws_s3_bucket.app_storage.bucket
  key    = "rails_app.env"

  content = templatefile("${path.module}/rails_app.env.tpl", {
    db_name        = var.db_name
    db_username    = var.db_username
    db_password    = var.db_password
    db_host        = var.db_host                 # ✅ FIXED: Use input variable
    s3_bucket_name = aws_s3_bucket.app_storage.bucket
    aws_region     = var.aws_region
    lb_endpoint    = var.lb_endpoint             # ✅ FIXED: Use input variable
  })

  content_type = "text/plain"

  tags = {
    Name = "${var.project_name}-env-file"
  }
}
