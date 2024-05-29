variable "region" {
  type        = string
  description = "AWS region where the terraform script need to be applied"
}

variable "main_vpc_cidr" {
  type        = string
  description = "VPC's main CIDR block eg : 10.0.0.0/16"
}

variable "vpc_name" {
  type        = string
  description = "VPC name"
}

variable "igw_name" {
  type        = string
  description = "InternetGateway name"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "Public subnets CIDR block list in array"
}

variable "availability_zones" {
  type        = list(any)
  description = "Availability Zone's list in array"
}

variable "environment" {
  type        = string
  description = "Environment name eg: Pre-staging, Staging, Prodction"
}

variable "nat_gw_name_1" {
  type        = string
  description = "1st NAT gateway name"
}

variable "private_subnet_rt_zone_1a" {
  type        = list(any)
  description = "Private subnet route table Zone 1a"
}

variable "private_subnet_rt_zone_1b" {
  type        = list(any)
  description = "Private subnet route table Zone 1b"
}

variable "private_subnet_rt_zone_1c" {
  type        = list(any)
  description = "Private subnet route table Zone 1c"
}

variable "product_name" {
  type        = string
  description = "Product name for the Resourcw Eg: DALink or Miton"

}
