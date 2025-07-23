module "vpc" {
  source                = "./modules/vpc"
  cidr_block            = var.cidr_block
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
}

module "alb" {
  source               = "./modules/alb"
  vpc_id               = module.vpc.vpc_id
  public_subnet_ids    = module.vpc.public_subnet_ids
  alb_sg_ingress_cidr  = var.alb_sg_ingress_cidr
}

module "rds" {
  source             = "./modules/rds"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  db_username        = var.db_username
  db_password        = var.db_password
  db_name            = var.db_name
}

module "s3" {
  source         = "./modules/s3"
  bucket_name    = var.bucket_name
  env_file_name  = var.env_file_name
  db_name        = var.db_name
  db_username    = var.db_username
  db_password    = var.db_password
  db_host        = module.rds.db_endpoint
}

module "ecs" {
  source                = "./modules/ecs"
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  cluster_name          = var.cluster_name
  service_name          = var.service_name
  container_name        = var.container_name
  image_url             = var.image_url
  cpu                   = var.cpu
  memory                = var.memory
  bucket_name           = module.s3.bucket_name
  env_file_name         = module.s3.env_file_key
  alb_target_group_arn  = module.alb.target_group_arn
  alb_sg_id             = module.alb.alb_sg_id
}

