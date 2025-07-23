variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "alb_target_group_arn" {
  type = string
}

variable "alb_sg_id" {
  type = string
}

variable "container_image_webserver" {
  type = string
}

variable "container_image_nginx" {
  type = string
}

variable "env_s3_bucket" {
  description = "S3 bucket name containing the env file"
  type        = string
}

variable "env_s3_key" {
  description = "S3 object key for the env file"
  type        = string
}


variable "aws_region" {
  type = string
}
