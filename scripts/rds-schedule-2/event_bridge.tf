resource "aws_scheduler_schedule" "ecs_scheduler_down" {
  name       = local.ecs_scheduler_down
  group_name = "default"
  flexible_time_window {
    mode = "OFF"
  }
  state                        = "ENABLED"
  schedule_expression          = "cron(0 16 ? * MON-FRI *)"
  schedule_expression_timezone = "Asia/Calcutta"
  target {
    arn      = var.LAMBDA_ARN
    role_arn = aws_iam_role.ecs_scheduler_iam_role.arn
    input = jsonencode({
           "schedule": "stop"
    })
    retry_policy {
      maximum_retry_attempts       = 5
      maximum_event_age_in_seconds = 3600
    }
  }
}

resource "aws_scheduler_schedule" "ecs_scheduler_up" {
  name       = local.ecs_scheduler_up
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }
  state                        = "ENABLED"
  schedule_expression          = "cron(30 3 ? * MON-FRI *)"
  schedule_expression_timezone = "UTC"
  target {
    arn      = var.LAMBDA_ARN
    role_arn = aws_iam_role.ecs_scheduler_iam_role.arn
    input = jsonencode({
      "schedule": "start"
    })
    retry_policy {
      maximum_retry_attempts       = 5
      maximum_event_age_in_seconds = 3600
    }
  }
}