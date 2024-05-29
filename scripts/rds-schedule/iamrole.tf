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


