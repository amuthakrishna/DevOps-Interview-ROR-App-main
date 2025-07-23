project_name              = "rails-app"
aws_region                = "ap-south-1"
vpc_cidr                  = "10.0.0.0/16"
availability_zones = ["ap-south-1a", "ap-south-1b"]
public_subnet_cidrs       = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs      = ["10.0.3.0/24", "10.0.4.0/24"]
alb_sg_ingress_cidr       = "0.0.0.0/0"

container_image_webserver = "123456789012.dkr.ecr.ap-south-1.amazonaws.com/rails-web:latest"
container_image_nginx     = "123456789012.dkr.ecr.ap-south-1.amazonaws.com/nginx:latest"

env_s3_bucket = "rail"
env_s3_key    = "env/rails-app.env"
