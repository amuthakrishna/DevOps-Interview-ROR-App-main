variable "project_name" {
  description = "Project name prefix for resources"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
}

variable "alb_sg_ingress_cidr" {
  description = "Ingress CIDR block for the ALB security group"
  type        = string
}

variable "container_image_webserver" {
  description = "Docker image URI for Rails webserver"
  type        = string
}

variable "container_image_nginx" {
  description = "Docker image URI for nginx container"
  type        = string
}

variable "env_s3_bucket" {
  description = "Name of the S3 bucket containing the .env file"
  type        = string
}

variable "env_s3_key" {
  description = "S3 key path to the .env file"
  type        = string
}
