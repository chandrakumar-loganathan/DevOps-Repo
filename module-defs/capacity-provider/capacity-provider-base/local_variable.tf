locals {
  lt=format("%s-lt",var.COMMON_NAME)
  lt_tag=format("%s",var.COMMON_NAME)
  iam_instance_profile=format("%s-ip",var.COMMON_NAME)
  instance_profile_role=format("%s-ip-role",var.COMMON_NAME)
  sg=format("%s-sg",var.COMMON_NAME)
  sg_tag=format("%s-sg",var.COMMON_NAME)
  environment_tag=format("%s",var.COMMON_NAME)
  module_tag=format("%s",var.ENVIRONMENT)
  cp=format("%s-cp",var.COMMON_NAME)
  asg=format("%s-asg",var.COMMON_NAME)
}