resource "aws_launch_template" "this" {
  name_prefix   = "web-lt-"
  image_id      = var.ec2_ami_id
  instance_type = var.ec2_instance_type
  user_data     = base64encode(file("${path.module}/userdata.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = var.tags
  }
}

resource "aws_autoscaling_group" "this" {
  name                      = "web-asg"
  desired_capacity          = var.asg_desired_capacity
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  vpc_zone_identifier       = var.private_subnet_ids
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.this.arn]
  depends_on = [aws_lb_listener.http]

  tags = [
    {
      key                 = "Name"
      value               = "web-asg"
      propagate_at_launch = true
    }
  ]
}

resource "aws_lb" "this" {
  name               = "web-alb"
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.alb_subnets
  tags               = var.tags
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group" "this" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  tags     = var.tags
}

# Temporary EC2 instance
resource "aws_instance" "example" {
  ami           = var.ec2_ami_id
  instance_type = var.ec2_instance_type
  subnet_id     = var.public_subnet_ids[0]
  security_groups = [var.ec2_sg_id]
  user_data     = base64encode(file("${path.module}/userdata.sh"))
  tags          = var.tags
}
