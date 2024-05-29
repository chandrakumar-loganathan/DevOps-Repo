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
variable "NGINX_CPU" {
  type = number
}
variable "NGINX_MEMORY" {
  type = number
}
variable "PHP_MEMORY_RESERVATION" {
  type = number
}
variable "AWS_REGION" {
  type = string
}

variable "NGINX_MEMORY_RESERVATION" {
  type = number
}
variable "VARSNISH_CPU" {
  type = number
}
variable "VARNISH_MEMORY" {
  type = number
}
variable "VARNISH_MEMORY_RESERVATION" {
  type = number
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
variable "ALB_LISTENER_PORT_80_PRIORITY" {
  type = string
}
variable "ALB_LISTENER_PORT_443_PRIORITY" {
  type = string
}
variable "ALB_LISTENER_RULE_HOST_HEADER" {
  type = string
}
variable "S3_BUCKET_LOAD_BALANCER" {
 type = string
}
variable "S3_BUCKET_PATH_LOAD_BALANCER" {
  type = string
}
variable "S3_BUCKET_AWS_REGION_LOAD_BALANCER" {
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