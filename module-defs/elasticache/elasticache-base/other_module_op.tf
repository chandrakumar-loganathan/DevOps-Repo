data "terraform_remote_state" "vpc" {
  # BACKEND-S3

  backend = "s3"
  config = {
    # Replace this with your bucket name!
    bucket = var.S3_BUCKET_VPC
    key    = var.S3_BUCKET_PATH_VPC
    region = var.S3_BUCKET_AWS_REGION_VPC
  }
}