output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "rds_endpoint" {
  value = module.rds.db_endpoint
}

output "s3_bucket_name" {
  value = module.s3.app_storage_bucket
}

output "ecs_service_name" {
  value = module.ecs.ecs_service_name
}