locals {
  sg=format("%s-rds-sg",var.COMMON_NAME)
  sg_tag=format("%s-rds-sg",var.COMMON_NAME)
  db_subnet_group_name=format("%s-rds-subnet",var.COMMON_NAME)
  db_subnet_group_tag=format("%s-rds-subnet-tag",var.COMMON_NAME)
}