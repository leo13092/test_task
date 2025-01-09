output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

output "example_instance_id" {
  value = aws_instance.example.id
}
