output "rds_endpoint" {
  description = "Full RDS endpoint with port"
  value       = aws_db_instance.postgres.endpoint
}

output "db_endpoint" {
  description = "DNS address of the RDS instance"
  value       = aws_db_instance.postgres.address
}

output "rds_security_group_id" {
  description = "Security Group ID created for the RDS instance"
  value       = aws_security_group.rds_sg.id
}
