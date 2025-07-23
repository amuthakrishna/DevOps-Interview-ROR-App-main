variable "env_s3_bucket" {
  description = "S3 bucket name to store env file"
  default     = "my-ecs-env-bucket"
}

variable "env_s3_key" {
  description = "Key (filename) for the uploaded env file"
  default     = "app.env"
}

variable "aws_region" {
  description = "AWS region"
}
