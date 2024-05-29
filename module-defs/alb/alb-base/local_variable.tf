locals {
  lb=format("%s-lb",var.COMMON_NAME)
  sg=format("%s-lb-sg",var.COMMON_NAME)
  sg_tag=format("%s-lb-sg",var.COMMON_NAME)
}