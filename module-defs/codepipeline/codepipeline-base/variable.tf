variable "REGION" {
  type        = string
  description = "AWS region where the terraform script need to be applied"
}

variable "COMMON_NAME" {
  type        = string
  description = ""
}

variable "SERVICE_ROLE_ARN" {
  type        = string
  description = ""
}

variable "REPO_ID" {
  type        = string
  description = ""
}

variable "BRANCH_NAME" {
  type        = string
  description = ""
}

variable "CLUSTER_NAME" {
  type        = string
  description = ""
}

variable "SERVICE_NAME" {
  type        = string
  description = ""
}

variable "VPC_ID" {
  type        = string
  description = ""
}

variable "PRIVATE_SUBNET_1" {
  type        = string
  description = ""
}

variable "ECR_QUERY" {
  type        = string
  description = ""
}

variable "WEB_REPO_URL" {
  type        = string
  description = ""
}

variable "NGINX_REPO_URL" {
  type        = string
  description = ""
}

variable "VARNISH_REPO_URL" {
  type        = string
  description = ""
}

variable "WEB_REPO_NAME" {
  type        = string
  description = ""
}

variable "NGINX_REPO_NAME" {
  type        = string
  description = ""
}

variable "VARNISH_REPO_NAME" {
  type        = string
  description = ""
}

variable "S3_ENV_FILE_PATH" {
  type        = string
  description = ""
}

variable "S3_MEDIA_FILE_PATH" {
  type        = string
  description = ""
}

variable "WEB_CONTAINER" {
  type        = string
  description = ""
}

variable "NGINX_CONTAINER" {
  type        = string
  description = ""
}

variable "VARNISH_CONTAINER" {
  type        = string
  description = ""
}

variable "REACT_PROJECT_NAME" {
  type        = string
  description = ""
}

variable "REACT_APP_BASE_URL" {
  type        = string
  description = ""
}

