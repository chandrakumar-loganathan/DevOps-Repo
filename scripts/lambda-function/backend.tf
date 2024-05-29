terraform {
  backend "s3" {
    bucket = "magento-qa-terraform-bucket"
    key = "statefile/scheduled_scaling_lambda"
    region = "us-west-2"
  }
}