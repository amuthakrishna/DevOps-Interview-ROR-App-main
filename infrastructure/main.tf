
module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "rds" {
  source               = "./modules/rds"
  private_subnet_ids   = module.vpc.private_subnets
  private_subnet_cidrs = var.private_subnet_cidrs
  vpc_id               = module.vpc.vpc_id
  db_username          = var.db_username
  db_password          = var.db_password
  db_name              = var.db_name
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnets
  target_group_port = 80
  project_name      = var.project_name
}

module "s3" {
  source        = "./modules/s3"
  env_s3_bucket = "my-ecs-env-bucket"
  env_s3_key    = "app.env"
  db_host       = module.rds.db_endpoint
  s3_bucket_name = "my-ecs-env-bucket"
  aws_region     = var.aws_region
  lb_endpoint    = module.alb.alb_dns_name
}

module "ecs" {
  source                    = "./modules/ecs"
  vpc_id                    = module.vpc.vpc_id
  private_subnet_ids        = module.vpc.private_subnets
  alb_target_group_arn      = module.alb.target_group_arn
  alb_sg_id                 = module.alb.alb_sg_id
  container_image_webserver = var.container_image_webserver
  container_image_nginx     = var.container_image_nginx
  env_s3_bucket             = module.s3.env_s3_bucket_name
  env_s3_key                = module.s3.env_s3_key
  aws_region                = var.aws_region
  project_name              = var.project_name
}


#module "ecr" {
#  source        = "./modules/ecr"
#  ecr_repo_name = "laravel"
#}
data "template_file" "rails_env" {
  template = file("${path.module}/modules/s3/env/rails-app.env.tpl")

  vars = {
    db_host         = module.rds.rds_endpoint
    lb_endpoint     = module.alb.alb_dns_name
    s3_bucket_name  = module.s3.bucket_name
    aws_region      = var.aws_region
  }
}

resource "aws_s3_object" "rails_env" {
  bucket = module.s3.bucket_name
  key    = "env/rails-app.env"
  content = data.template_file.rails_env.rendered
  content_type = "text/plain"
}
