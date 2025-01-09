**Prerequisites:**

- Terraform >= 1.3.0
- AWS CLI configured with appropriate credentials (or set AWS_PROFILE/AWS_ACCESS_KEY_ID, etc.)
- An S3 bucket and DynamoDB table created for remote state storage (optional steps below).
- Update `ami_id` variable with a valid AMI in your chosen region.
- Make sure you have an SSH key pair or any required credentials if needed for debugging (not explicitly required for this test).

**Steps to Initialize, Plan, and Apply:**

1. Clone this repository.
2. Ensure you have created:
   - An S3 bucket (e.g., `my-terraform-state-bucket`) in the region for remote state.
   - A DynamoDB table (e.g., `terraform-lock`) with a primary key `LockID` for state locking.
3. In `backend.tf` or as variables, set `var.backend_bucket` and `var.backend_lock_table` accordingly.
4. Run `terraform init` to initialize providers and modules.
5. Run `terraform plan` to see the proposed changes.
6. Run `terraform apply` to create the infrastructure. Confirm with "yes" when prompted.
   
**Verification Steps:**

- **EC2 Access via Load Balancer:** After `terraform apply` completes, it will output `alb_dns_name`. Open `http://alb_dns_name` in your browser. You should see the default Nginx welcome page, indicating that traffic is flowing through the ALB to the EC2 instances.

- **RDS Database Reachability from EC2:**

  1. SSH into one of the EC2 instances (if you have access; for a production setup you might rely on a bastion or SSM Session Manager).
  2. Run `nc -vz <rds_endpoint> 3306` or use `mysql` client (if installed) to verify you can connect to the RDS endpoint on the private subnet.
  3. You should be able to connect since the RDS SG allows inbound traffic from the EC2 SG.

 
**Assumptions & Limitations:**

- The AMI ID must be provided. Here we assume a generic Ubuntu or Amazon Linux AMI is available.
- We assume Nginx is installed via apt-get (Ubuntu/Debian). If using Amazon Linux, adjust the user data to use `yum`.
- The NAT Gateway and ALB incur costs. This is a test environment; clean up when done (`terraform destroy`).

**Optional Enhancements:**

- Add IAM roles and attach them to the EC2 instances if needed.
- Add CloudWatch alarms by creating `aws_cloudwatch_metric_alarm` resources.
- Integrate with Terraform Cloud or GitHub Actions for CI/CD by creating a `.github/workflows` pipeline config.

**Terraform Plan Output (Optional):**

- Running `terraform plan` will show you the resources that will be created (VPC, subnets, EC2 instance, ALB, ASG, RDS, etc.). Due to the dynamic nature of the code, the exact output will vary depending on your configuration and variables.