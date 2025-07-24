project_name         = "ror-app"
aws_region           = "ap-south-1"

vpc_cidr_block       = "10.0.0.0/16"

public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

db_name              = "rorappdb"
db_username          = "admin"
db_password          = "YourStrongDBPassword123!" # Replace with secure password

alb_sg_ingress_cidr  = ["0.0.0.0/0"]

ecs_desired_count    = 2

env_s3_key           = "rails_app.env"
