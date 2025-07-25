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
  type = string
}

variable "env_s3_key" {
  type = string
}

variable "aws_region" {
  type = string
}
