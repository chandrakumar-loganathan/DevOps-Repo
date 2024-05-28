terraform {
  backend "s3" {
    bucket = "magento-qa-terraform-bucket"
    key = "statefile/ssm-state-file"
    region = "us-west-2"
  }
}