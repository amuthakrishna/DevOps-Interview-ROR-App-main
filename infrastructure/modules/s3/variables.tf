
variable "aws_region" {
  description = "AWS region where S3 bucket is created"
  type        = string
}

variable "env_s3_bucket" {
  description = "Name of the S3 bucket containing the .env file"
  type        = string
  default = "rail-app"
}
variable "env_s3_key" {
  description = "Key path to the .env file in the S3 bucket"
  type        = string
}

variable "db_host" {
  description = "Database hostname"
  type        = string
}

variable "lb_endpoint" {
  description = "Load balancer endpoint"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}