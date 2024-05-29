data "terraform_remote_state" "module_ecs" {
  # BACKEND-S3
  backend = "s3"
  config = {
    # Replace this with your bucket name!
    bucket = var.S3_BUCKET_ECS
    key    = var.S3_BUCKET_PATH_ECS
    region = var.S3_BUCKET_AWS_REGION_ECS
  }
}
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
data "terraform_remote_state" "cp" {
  backend = "s3"
  config = {
    # Replace this with your bucket name!
    bucket = var.S3_BUCKET_ECS_CP
    key    = var.S3_BUCKET_PATH_ECS_CP
    region = var.S3_BUCKET_AWS_REGION_ECS_CP
  }
}