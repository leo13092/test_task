variable "ec2_instance_id" {}
variable "availability_zone" {}
variable "volume_size" {
  type = number
}
variable "volume_type" {
  type = string
}
variable "tags" {
  type = map(string)
}
