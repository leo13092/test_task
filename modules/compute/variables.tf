variable "vpc_id" {}
variable "public_subnet_ids" {
  type = list(string)
}
variable "private_subnet_ids" {
  type = list(string)
}
variable "alb_subnets" {
  type = list(string)
}
variable "ec2_ami_id" {}
variable "ec2_instance_type" {}
variable "asg_min_size" {
  type = number
}
variable "asg_max_size" {
  type = number
}
variable "asg_desired_capacity" {
  type = number
}
variable "ec2_sg_id" {}
variable "alb_sg_id" {}
variable "tags" {
  type = map(string)
}
