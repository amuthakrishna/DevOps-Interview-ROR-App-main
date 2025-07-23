provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source              = "./modules/vpc"
  
  availability_zones  = var.availability_zones
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "alb" {
  source               = "./modules/alb"
  project_name         = var.project_name
  vpc_id               = module.vpc.vpc_id
  public_subnet_ids    = module.vpc.public_subnets
  alb_sg_ingress_cidr  = var.alb_sg_ingress_cidr
}

module "rds" {
  source               = "./modules/rds"
  project_name         = var.project_name
  private_subnet_ids   = module.vpc.private_subnets
  private_subnet_cidrs = var.private_subnet_cidrs
  vpc_id               = module.vpc.vpc_id

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}

module "s3" {
  source         = "./modules/s3"
  bucket_name    = var.env_s3_bucket
  aws_region     = var.aws_region
  env_s3_key     = var.env_s3_key
  
  # Pass database and ALB info to create env file
  db_host      = module.rds.db_endpoint
  lb_endpoint  = module.alb.alb_dns_name
  db_name      = var.db_name
  db_username  = var.db_username
  db_password  = var.db_password
}

module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
}

module "ecs" {
  source                    = "./modules/ecs"
  vpc_id                    = module.vpc.vpc_id
  private_subnet_ids        = module.vpc.private_subnets
  alb_target_group_arn      = module.alb.target_group_arn
  alb_sg_id                 = module.alb.alb_sg_id
  container_image_webserver = var.container_image_webserver
  container_image_nginx     = var.container_image_nginx
  env_s3_bucket             = var.env_s3_bucket
  env_s3_key                = var.env_s3_key
  aws_region                = var.aws_region
  project_name              = var.project_name
}