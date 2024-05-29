locals {
  ecs_scheduler_iam_role=format("%s-scheduler-role",var.COMMON_NAME)
  ecs_scheduler_policy=format("%s-scheduler-policy",var.COMMON_NAME)
  ecs_scheduler_down=format("%s-schduler-down",var.COMMON_NAME)
  ecs_scheduler_up=format("%s-scheduler-up",var.COMMON_NAME)
}