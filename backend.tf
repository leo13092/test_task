terraform {
  backend "s3" {
    bucket         = var.backend_bucket
    key            = "terraform.tfstate"
    region         = var.region
    dynamodb_table = var.backend_lock_table
    encrypt        = true
  }
}
