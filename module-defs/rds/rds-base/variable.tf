variable "DB_NAME" {
  type = string
}
variable "DB_ENGINE_VERSION" {
  type = string
}

variable "DB_ENGINE_CLASS" {
  type = string
}
variable "MASTER_DB_NAME" {
  type = string
}
variable "PASSWORD" {
  type = string
}
variable "USER_NAME" {
  type = string
}
variable "COMMON_NAME" {
  type=string
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