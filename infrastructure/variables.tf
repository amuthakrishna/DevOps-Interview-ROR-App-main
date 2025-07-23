variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "rails-app"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDRs for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDRs for private subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "env_s3_bucket" {
  description = "Name of the S3 bucket containing the .env file"
  type        = string
}

variable "env_s3_key" {
  description = "Key path to the .env file in the S3 bucket"
  type        = string
  default     = "env/rails-app.env"
}

variable "alb_sg_ingress_cidr" {
  description = "CIDR blocks allowed to access ALB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "railsapp"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Database password"
  type        = string
  default     = "krishnamoorthy123"
}

variable "container_image_webserver" {
  description = "Docker image for Rails webserver"
  type        = string
}

variable "container_image_nginx" {
  description = "Docker image for Nginx"
  type        = string
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
  default     = "latest"
}