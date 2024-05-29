resource "aws_ecs_cluster" "cluster" {
  name = local.cluster_name
  
  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

variable "COMMON_NAME" {
  type=string
}

locals {
  cluster_name=format("%s-cluster",var.COMMON_NAME)
}
