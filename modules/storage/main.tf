resource "aws_ebs_volume" "this" {
  availability_zone = var.availability_zone
  size              = var.volume_size
  type              = var.volume_type
  tags              = var.tags
}

resource "aws_volume_attachment" "this" {
  device_name  = "/dev/xvdf"
  volume_id    = aws_ebs_volume.this.id
  instance_id  = var.ec2_instance_id
  depends_on   = [aws_ebs_volume.this]
}
