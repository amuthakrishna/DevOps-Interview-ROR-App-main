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
