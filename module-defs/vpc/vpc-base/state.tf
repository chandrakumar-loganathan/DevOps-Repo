terraform {
  backend "s3" {
    bucket = "magento-testing-bucket"
    key = "terraform-state-file/magento-vpc-state-file"
    region = "us-west-2"
  }
}