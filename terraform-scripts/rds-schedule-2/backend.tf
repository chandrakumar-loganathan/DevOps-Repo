terraform {
  backend "s3" {
    bucket = "magento-qa-terraform-bucket"
    key = "statefile/rds-scheduled-scaling-lambda"
    region = "us-west-2"
  }
}