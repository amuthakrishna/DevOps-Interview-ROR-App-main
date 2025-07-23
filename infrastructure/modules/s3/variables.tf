variable "env_s3_bucket" {
  description = "Name of the S3 bucket containing the .env file"
  type        = string
}

variable "env_s3_key" {
  description = "Key path to the .env file in the S3 bucket"
  type        = string
}



variable "bucket_name" {
  description = "S3 bucket name for environment file"
  type        = string
}

variable "aws_region" {
  description = "AWS region where S3 bucket is created"
  type        = string
}
