provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source               = "./infrastructure/vpc"
  cidr_block           = var.vpc_cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "rds" {
  source               = "./infrastructure/rds"
  vpc_id               = module.vpc.vpc_id
  private_subnet_ids   = module.vpc.private_subnets
  private_subnet_cidrs = var.private_subnet_cidrs
  db_username          = var.db_username
  db_password          = var.db_password
  db_name              = var.db_name
}

module "s3" {
  source       = "./infrastructure/s3"
  project_name = var.project_name
  db_name      = var.db_name
  db_username  = var.db_username
  db_password  = var.db_password
  db_host      = module.rds.db_endpoint
  aws_region   = var.aws_region
  lb_endpoint  = module.alb.alb_dns_name
}

module "alb" {
  source              = "./infrastructure/alb"
  project_name        = var.project_name
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnets
  alb_sg_ingress_cidr = var.alb_sg_ingress_cidr
}


module "ecs" {
  source                  = "./infrastructure/ecs"
  project_name            = var.project_name
  vpc_id                  = module.vpc.vpc_id
  private_subnet_ids      = module.vpc.private_subnets
  alb_target_group_arn    = module.alb.target_group_arn
  alb_sg_id               = module.alb.alb_sg_id
  container_image_webserver = var.container_image_webserver
  container_image_nginx  = var.container_image_nginx
  env_s3_bucket          = module.s3.app_storage_bucket
  env_s3_key             = "rails_app.env"
  aws_region             = var.aws_region
}
