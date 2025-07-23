variable "env_s3_bucket" {
  description = "S3 bucket name to store env file"
  default     = "my-ecs-env-bucket"
}

variable "env_s3_key" {
  description = "Key (filename) for the uploaded env file"
  default     = "app.env"
}

variable "db_name" {}
variable "db_username" {}
variable "db_password" {}
variable "db_host" {}

variable "s3_bucket_name" {}
variable "aws_region" {}
variable "lb_endpoint" {}
