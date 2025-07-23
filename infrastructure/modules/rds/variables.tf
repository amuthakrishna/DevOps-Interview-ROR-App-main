variable "private_subnet_ids" {
  description = "List of private subnet IDs for RDS"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets (used in SG rules)"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where RDS is deployed"
  type        = string
}

variable "db_username" {
  description = "Username for the RDS database"
  type        = string
}

variable "db_password" {
  description = "Password for the RDS database"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Database name for the RDS instance"
  type        = string
}
