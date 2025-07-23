# RDS Subnet Group
resource "aws_db_subnet_group" "rds" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "rds-subnet-group"
  }
}


# RDS Security Group
resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow PostgreSQL access from private subnets"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.private_subnet_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

# RDS Instance
resource "aws_db_instance" "postgres" {
  identifier        = "my-postgres-db"
  engine            = "postgres"
  engine_version    = "13"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp3"

  db_subnet_group_name   = aws_db_subnet_group.rds.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  username = var.db_username
  password = var.db_password
  db_name  = var.db_name

  publicly_accessible = false
  multi_az            = false
  skip_final_snapshot = true
  deletion_protection = false
  apply_immediately   = true


  tags = {
    Name = "rds-postgres"
  }
}
