module "network" {
  source             = "./modules/network"
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr= var.private_subnet_cidr
  tags               = var.tags
}

module "security" {
  source = "./modules/security"
  vpc_id = module.network.vpc_id

  # The security module will define SGs for EC2, ALB, and RDS and output them.
  tags = var.tags
}

module "compute" {
  source              = "./modules/compute"
  vpc_id              = module.network.vpc_id
  public_subnet_ids   = [module.network.public_subnet_id]
  private_subnet_ids  = [module.network.private_subnet_id]
  ec2_instance_type   = var.instance_type
  ec2_ami_id          = var.ami_id
  asg_min_size        = var.asg_min_size
  asg_max_size        = var.asg_max_size
  asg_desired_capacity= var.asg_desired_capacity
  alb_subnets         = [module.network.public_subnet_id]
  ec2_sg_id           = module.security.ec2_sg_id
  alb_sg_id           = module.security.alb_sg_id
  tags                = var.tags
}

module "storage" {
  source          = "./modules/storage"
  ec2_instance_id = module.compute.example_instance_id
  volume_size     = 10
  volume_type     = "gp2"
  availability_zone = module.network.vpc_az
  tags            = var.tags
}

module "database" {
  source              = "./modules/database"
  private_subnet_ids  = [module.network.private_subnet_id]
  vpc_id              = module.network.vpc_id
  db_instance_class   = var.rds_instance_class
  db_engine           = var.rds_engine
  db_engine_version   = var.rds_engine_version
  db_username         = var.rds_username
  db_password         = var.rds_password
  allocated_storage   = var.rds_allocated_storage
  rds_sg_id           = module.security.rds_sg_id
  ec2_sg_id           = module.security.ec2_sg_id
  tags                = var.tags
}
