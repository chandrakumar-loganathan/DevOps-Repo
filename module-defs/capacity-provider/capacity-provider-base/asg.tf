resource "aws_autoscaling_group" "asg" {
  name = local.asg
  # availability_zones = []
  vpc_zone_identifier       = concat( sort(data.terraform_remote_state.vpc.outputs.subnet_1),sort(data.terraform_remote_state.vpc.outputs.subnet_2),sort(data.terraform_remote_state.vpc.outputs.subnet_3))
  desired_capacity          = var.DESIRED_INSTANCE_COUNT
  min_size                  = var.MIN_INSTANCE_COUNT
  max_size                  = var.MAX_INSTANCE_COUNT
  protect_from_scale_in     = true
  health_check_grace_period = 300
  health_check_type         = "EC2"
  default_cooldown          = 30
  capacity_rebalance        = "true"
  termination_policies      = ["Default"]
  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity  = 0
    }
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.lt.id
      }
    }
  }
}
resource "aws_autoscaling_schedule" "schedule_up" {
  scheduled_action_name  = "scheduled up"
  min_size               = var.MIN_SIZE_SCHEDULE_UP
  max_size               = var.MAX_SIZE_SCHEDULE_UP
  desired_capacity       = var.DESIRED_SIZE_SCHEDULE_UP
  autoscaling_group_name = aws_autoscaling_group.asg.name
  recurrence             = var.INSTANCE_SCALE_UP_CRON
}
resource "aws_autoscaling_schedule" "schedule_down" {
  scheduled_action_name  = "scheduled down"
  min_size               = var.MIN_SIZE_SCHEDULE_DOWN
  max_size               = var.MAX_SIZE_SCHEDULE_DOWN
  desired_capacity       = var.DESIRED_SIZE_SCHEDULE_DOWN
  autoscaling_group_name = aws_autoscaling_group.asg.name
  recurrence             = var.INSTANCE_SCALE_DOWN_CRON
}