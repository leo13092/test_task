variable "private_subnet_ids" {
  type = list(string)
}
variable "vpc_id" {}
variable "db_engine" {}
variable "db_engine_version" {}
variable "db_instance_class" {}
variable "db_username" {}
variable "db_password" {
  sensitive = true
}
variable "allocated_storage" {
  type = number
}
variable "rds_sg_id" {}
variable "ec2_sg_id" {}
variable "tags" {
  type = map(string)
}
