variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "db_name" {
  description = "RDS database name"
  type        = string
}

variable "db_username" {
  description = "RDS username"
  type        = string
}

variable "db_password" {
  description = "RDS password"
  type        = string
  sensitive   = true
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "alb_sg_ingress_cidr" {
  description = "Allowed CIDR blocks to access ALB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ecs_desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
  default     = 2
}

variable "env_s3_key" {
  description = "Key (filename) of the environment file in S3"
  type        = string
  default     = "rails_app.env"
}
