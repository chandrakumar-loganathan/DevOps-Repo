terraform {
  backend "s3" {
    bucket = "magento-production-terraform-bucket"
    key = "statefile/scheduled-scaling-rds-schedule-state-file"
    region = "us-west-2"
  }
}