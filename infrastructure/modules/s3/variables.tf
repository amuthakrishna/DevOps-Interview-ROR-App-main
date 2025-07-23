variable "env_s3_bucket" {
  description = "S3 bucket name to store env file"
  default     = "my-ecs-env-bucket"
}

variable "env_s3_key" {
  description = "Key (filename) for the uploaded env file"
  default     = "app.env"
}


variable "bucket_name" {
  description = "S3 bucket name for environment file"
  type        = string
}

variable "aws_region" {
  description = "AWS region where S3 bucket is created"
  type        = string
}
