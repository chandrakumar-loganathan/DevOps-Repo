resource "aws_ssm_document" "ssm_document" {
  name            = "${var.DOCUMENT_NAME}"
  document_type   = "Automation"
  document_format = "YAML"
  content =  templatefile("ssm_document.yaml", {
    AutomationexecuteRoleArn =  aws_iam_role.ssm_iam_role.arn,
    MinimumRequiredApproval = 1
    cloudwatch_grp_name = var.CLOUDWATCH_GROUP_NAME,
    AutomationexecuteRoleArn =  aws_iam_role.ssm_iam_role.arn,
    MinimumRequiredApproval = 1
    } )
}