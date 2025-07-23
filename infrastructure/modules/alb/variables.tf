variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "target_group_port" {
  description = "Port for the Target Group"
  type        = number
  default     = 80
}

variable "alb_sg_ingress_cidr" {
  description = "CIDR blocks allowed to access ALB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}