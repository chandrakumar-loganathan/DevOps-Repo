locals {
  domain=format("%s-domain",var.COMMON_NAME)
  domain_tag=format("%s-tag",var.COMMON_NAME)
  sg=format("%s-opensearch-sg",var.COMMON_NAME)
}