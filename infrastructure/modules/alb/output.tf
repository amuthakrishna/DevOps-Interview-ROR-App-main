output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.app.dns_name
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = aws_lb.app.arn
}

output "alb_sg_id" {
  description = "Security Group ID of the ALB"
  value       = aws_security_group.alb.id
}

output "target_group_arn" {
  description = "ARN of the ALB Target Group"
  value       = aws_lb_target_group.app.arn
}
