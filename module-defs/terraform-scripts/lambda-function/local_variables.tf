locals{
    scheduled_scaling_lambda_function = format("%s-lambda-functions",var.COMMON_NAME)
    scheduled_scaling_lambda_role = format("%s-role",var.COMMON_NAME)
    scheduled_scaling_lambda_policy = format("%s-policy",var.COMMON_NAME)
    scheduled_scaling_lambda_log = format("/aws/lambda/%s",local.scheduled_scaling_lambda_function)
}