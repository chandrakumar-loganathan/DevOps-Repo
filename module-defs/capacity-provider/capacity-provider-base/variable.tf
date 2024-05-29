variable "COMMON_NAME" {
  type = string
}
variable "ECS_AMI" {
  type = string
}
variable "INSTANCE_TYPE" {
  type = string
}
variable "EC2_INSTANCE_PROFILE_CONTAINER_SERVICE_FOR_EC2_ROLE" {
  type = string
}
variable "EC2_INSTANCE_PROFILE_MANAGED_INSTANCE_CORE" {
  type = string
}
variable "ENVIRONMENT" {
  type = string
}
variable "S3_BUCKET_ECS" {
  type = string
}
variable "S3_BUCKET_PATH_ECS" {
  type = string
}
variable "S3_BUCKET_AWS_REGION_ECS" {
  type = string
}
variable "DESIRED_INSTANCE_COUNT" {
  type = string
}
variable "MIN_INSTANCE_COUNT" {
  type = string
}
variable "MAX_INSTANCE_COUNT" {
  type = string
}
variable "S3_BUCKET_VPC" {
  type = string
}
variable "S3_BUCKET_PATH_VPC" {
  type = string
}
variable "S3_BUCKET_AWS_REGION_VPC" {
  type = string
}

variable "MAX_SIZE_SCHEDULE_UP" {
  type = string
}
variable "DESIRED_SIZE_SCHEDULE_UP" {
  type = string
}
variable "INSTANCE_SCALE_UP_CRON" {
  type = string
}
variable "MIN_SIZE_SCHEDULE_UP" {
type = string
}
variable "MIN_SIZE_SCHEDULE_DOWN" {
  type = string
}
variable "MAX_SIZE_SCHEDULE_DOWN" {
 type = string 
}

variable "DESIRED_SIZE_SCHEDULE_DOWN" {
  type = string
}
variable "INSTANCE_SCALE_DOWN_CRON" {
  type = string
}