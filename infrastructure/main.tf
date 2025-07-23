module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "s3" {
  source         = "./modules/s3"
  bucket_name    = var.s3_bucket_name
  aws_region     = var.aws_region
  env_s3_key     = "env/rails-app.env"
  env_s3_bucket  = var.s3_bucket_name
}

# Load existing .env file from S3 and parse RDS credentials
data "aws_s3_object" "rails_env_file" {
  bucket = var.bucket_name
  key    = var.env_s3_key
}

locals {
  rails_env_content = data.aws_s3_object.rails_env_file.body

  db_name     = regex("(?m)^RDS_DB_NAME=(.*)$", local.rails_env_content)[0]
  db_username = regex("(?m)^RDS_USERNAME=(.*)$", local.rails_env_content)[0]
  db_password = regex("(?m)^RDS_PASSWORD=(.*)$", local.rails_env_content)[0]
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

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnets
  target_group_port = 80
  project_name      = var.project_name
}

module "ecs" {
  source                     = "./modules/ecs"
  vpc_id                     = module.vpc.vpc_id
  private_subnet_ids         = module.vpc.private_subnets
  alb_target_group_arn       = module.alb.target_group_arn
  alb_sg_id                  = module.alb.alb_sg_id
  container_image_webserver  = var.container_image_webserver
  container_image_nginx      = var.container_image_nginx
  env_s3_bucket              = var.env_s3_bucket
  env_s3_key                 = var.env_s3_key
  aws_region                 = var.aws_region
  project_name               = var.project_name
}
