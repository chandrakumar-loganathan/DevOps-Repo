variable "COMMON_NAME" {
  type = string
}
variable "TASK_MEMORY" {
  type = number
}
variable "PHP_CPU" {
  type = number
}
variable "PHP_MEMORY" {
  type = number
}
variable "PHP_MEMORY_RESERVATION" {
  type = number
}
variable "AWS_REGION" {
  type = string
}
variable "SERVICE_DESIREED_COUNT" {
  type = string
}
variable "SERVICE_MAX_COUNT" {
  type = string
}
variable "SERVICE_MIN_COUNT" {
  type = string
}
variable "SERVICE_MIN_HEALTH_PERCENT" {
  type=string
}
variable "SERVICE_MAX_HEALTH_PERCENT" {
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

variable "S3_BUCKET_VPC" {
  type = string
}
variable "S3_BUCKET_PATH_VPC" {
  type = string
}
variable "S3_BUCKET_AWS_REGION_VPC" {
  type = string
}

variable "S3_BUCKET_ECS_CP" {
  type = string
}
variable "S3_BUCKET_PATH_ECS_CP" {
  type = string
}
variable "S3_BUCKET_AWS_REGION_ECS_CP" {
  type = string
}

variable "ECR_QUERY" {
  type = string
}
variable "S3_MEDIA_FILE_PATH" {
  type = string
}
variable "REGION" {
  type = string
}
variable "SERVICE_ROLE_ARN" {
  type =string
}
variable "REPO_ID" {
  type = string
}
variable "BRANCH_NAME" {
  type = string
}
variable "S3_ENV_FILE_PATH" {
  type = string
}
variable "S3_ENV_FILE_REGION" {
  type = string
}
variable "REPO_NAME" {
  type = string
}
variable "OAUTH_TOKEN" {
  type = string
}
variable "REPO_OWNER" {
  type = string
}
variable "BUILD_SPEC_PATH" {
  type = string
}
variable "IMAGE_FILE_NAME" {
  type = string
}
variable "DOCKER_USERNAME" {
  type = string
}
variable "DOCKER_PASSWORD" {
  type = string
}