provider "aws" {
  region = var.aws_region
}

data "aws_s3_object" "rails_env_file" {
  bucket = var.env_s3_bucket
  key    = var.env_s3_key
}

locals {
  rails_env_content = data.aws_s3_object.rails_env_file.body

  db_name         = regex("(?m)^RDS_DB_NAME=(.*)$", local.rails_env_content)[0]
  db_username     = regex("(?m)^RDS_USERNAME=(.*)$", local.rails_env_content)[0]
  db_password     = regex("(?m)^RDS_PASSWORD=(.*)$", local.rails_env_content)[0]
  s3_bucket_name  = regex("(?m)^S3_BUCKET_NAME=(.*)$", local.rails_env_content)[0]
  s3_region_name  = regex("(?m)^S3_REGION_NAME=(.*)$", local.rails_env_content)[0]
}

module "vpc" {
  source              = "./modules/vpc"
  project_name        = var.project_name
  aws_region          = var.aws_region
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
  private_subnet_ids   = module.vpc.private_subnets
  private_subnet_cidrs = var.private_subnet_cidrs
  vpc_id               = module.vpc.vpc_id

  db_name     = local.db_name
  db_username = local.db_username
  db_password = local.db_password
}

module "s3" {
  source         = "./modules/s3"
  bucket_name    = local.s3_bucket_name
  aws_region     = local.s3_region_name
  env_s3_key     = var.env_s3_key
  env_s3_bucket  = local.s3_bucket_name
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
  env_s3_bucket             = local.s3_bucket_name
  env_s3_key                = var.env_s3_key
  aws_region                = local.s3_region_name
  project_name              = var.project_name
}
