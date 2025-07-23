output "db_host" {
  value = module.rds.rds_endpoint
}

output "lb_endpoint" {
  value = module.alb.alb_dns_name
}
