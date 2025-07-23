variable "project_name" {
  default = "rails-app"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "availability_zones" {
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "db_username" {
  description = "RDS DB username"
  type        = string
}

variable "db_password" {
  description = "RDS DB password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "RDS DB name"
  type        = string
}



variable "aws_region" {
  default = "ap-south-1"
}

variable "container_image_webserver" {
  type = string
}

variable "container_image_nginx" {
  type = string
}
