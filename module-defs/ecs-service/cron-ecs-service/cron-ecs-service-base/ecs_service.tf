resource "aws_ecs_service" "service" {
  name            = local.ecs_service
  cluster         = data.terraform_remote_state.module_ecs.outputs.cluster
  task_definition = aws_ecs_task_definition.tdf.arn
  desired_count   = var.SERVICE_DESIREED_COUNT
  deployment_maximum_percent         = var.SERVICE_MAX_HEALTH_PERCENT
  deployment_minimum_healthy_percent = var.SERVICE_MIN_HEALTH_PERCENT
  enable_ecs_managed_tags            = true
  propagate_tags                     = "TASK_DEFINITION" 
  scheduling_strategy                = "REPLICA" 
  wait_for_steady_state              = false
  capacity_provider_strategy {
    base              = 0
    weight            = 1
    capacity_provider = data.terraform_remote_state.cp.outputs.cp
  }
  deployment_circuit_breaker {
    enable = true
    rollback = true
  }

  ordered_placement_strategy {
    type  = "binpack"
    field = "memory"
  }

}

resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = var.SERVICE_MAX_COUNT
  min_capacity       = var.SERVICE_MIN_COUNT
  resource_id        = "service/${data.terraform_remote_state.module_ecs.outputs.cluster}/${aws_ecs_service.service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

