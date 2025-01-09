variable "region" {
  type    = string
  default = "us-east-1"
}

variable "aws_profile" {
  type    = string
  default = "default"
}

variable "backend_bucket" {
  type = string
}

variable "backend_lock_table" {
  type = string
}

# Networking
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

# Compute
variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ami_id" {
  type    = string
  description = "AMI ID for the EC2 instances"
}

variable "asg_min_size" {
  type    = number
  default = 2
}

variable "asg_max_size" {
  type    = number
  default = 4
}

variable "asg_desired_capacity" {
  type    = number
  default = 2
}

# RDS
variable "rds_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "rds_engine" {
  type    = string
  default = "mysql"
}

variable "rds_engine_version" {
  type    = string
  default = "8.0"
}

variable "rds_username" {
  type    = string
  default = "admin"
}

variable "rds_password" {
  type    = string
  sensitive = true
}

variable "rds_allocated_storage" {
  type    = number
  default = 20
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "test"
    ManagedBy   = "Terraform"
  }
}
