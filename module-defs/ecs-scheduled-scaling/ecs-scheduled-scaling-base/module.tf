data "aws_iam_policy_document" "ecs_scheduler_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["scheduler.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}
resource "aws_iam_role" "ecs_scheduler_iam_role" {
  name               = local.ecs_scheduler_iam_role
  assume_role_policy = data.aws_iam_policy_document.ecs_scheduler_assume_role.json
}

data "aws_iam_policy_document" "ecs_scheduler_iam_policy" {
  statement {
    effect = "Allow"
    resources = [
      format(var.LAMBDA_ARN)
    ]
    actions = [
      "lambda:InvokeFunction"
    ]
  }
}

resource "aws_iam_policy" "ecs_scheduler_iam_policy" {
  name   = local.ecs_scheduler_policy
  policy = data.aws_iam_policy_document.ecs_scheduler_iam_policy.json
}



resource "aws_iam_role_policy_attachment" "ecs_scheduler_attach_role_policy" {
  role       = aws_iam_role.ecs_scheduler_iam_role.name
  policy_arn = aws_iam_policy.ecs_scheduler_iam_policy.arn
}


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
      CLUSTER_NAME  = var.CLUSTER_NAME
      SERVICE_NMAE  = var.SERVICE_NAME
      DESIRED_COUNT = 0
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
      CLUSTER_NAME  = var.CLUSTER_NAME
      SERVICE_NMAE  = var.SERVICE_NAME
      DESIRED_COUNT = 0
    })
    retry_policy {
      maximum_retry_attempts       = 5
      maximum_event_age_in_seconds = 3600
    }
  }
}