provider "aws" {
  default_tags {
    tags = {
      Environment = local.environment_tag
      Module      = local.module_tag
    }
  }
}