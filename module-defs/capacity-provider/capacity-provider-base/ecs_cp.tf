
resource "aws_ecs_capacity_provider" "cp" {
  name = local.cp
  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.asg.arn
    managed_draining               = "ENABLED"
    managed_termination_protection = "ENABLED"
    managed_scaling {
      status                    = "ENABLED"
      target_capacity           = 100
      instance_warmup_period    = 300
      maximum_scaling_step_size = 10000
      minimum_scaling_step_size = 1
    }
  }
}





resource "aws_ecs_cluster_capacity_providers" "capacity" {
  cluster_name       = data.terraform_remote_state.module_ecs.outputs.cluster
  capacity_providers = [ aws_ecs_capacity_provider.cp.name ]
}
