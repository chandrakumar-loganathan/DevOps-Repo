data "aws_iam_policy_document" "scheduled_scaling_lambda_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}
resource "aws_iam_role" "scheduled_scaling_lambda_role" {
  name               = local.scheduled_scaling_lambda_role
  assume_role_policy = data.aws_iam_policy_document.scheduled_scaling_lambda_assume_role.json
}
data "aws_iam_policy_document" "scheduled_scaling_lambda_policy" {
  statement {
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
  }
  statement {
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "ecs:UpdateService"
    ]
  }
}
resource "aws_iam_policy" "scheduled_scaling_lambda_policy" {
  name   = local.scheduled_scaling_lambda_policy
  policy = data.aws_iam_policy_document.scheduled_scaling_lambda_policy.json
}
resource "aws_iam_role_policy_attachment" "scheduled_scaling_lambda_policy" {
  role       = aws_iam_role.scheduled_scaling_lambda_role.name
  policy_arn = aws_iam_policy.scheduled_scaling_lambda_policy.arn
}




data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "lambda_function.zip"
}

resource "aws_lambda_function" "scheduler_lambda" {
  filename      = "lambda_function.zip"
  function_name = local.scheduled_scaling_lambda_function
  role          = aws_iam_role.scheduled_scaling_lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  timeout       = "15"
  runtime       = "python3.10"
  description   = "This is the lambda function to instance scheduler"
  architectures = ["arm64"]
  ephemeral_storage {
    size = 512
  }
  memory_size                    = 128
  reserved_concurrent_executions = -1
  snap_start {
    apply_on = "None"
  }
}
resource "aws_lambda_function_event_invoke_config" "lambda_function_error_handling" {
  function_name                = aws_lambda_function.scheduler_lambda.function_name
  maximum_event_age_in_seconds = 3600
  maximum_retry_attempts       = 2
}


resource "aws_cloudwatch_log_group" "scheduler_log_group" {
  name              = local.scheduled_scaling_lambda_log
  retention_in_days = "7"
  skip_destroy      = false
  kms_key_id        = ""
}


