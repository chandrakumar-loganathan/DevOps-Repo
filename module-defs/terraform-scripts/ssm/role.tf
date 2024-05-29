data "aws_iam_policy_document" "ssm_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ssm.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

#Need to update the policy according to the least privileage policy, will be done later as a improvement. 

data "aws_iam_policy_document" "worker_iam_policy" {
  statement {
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "*"
    ]
  }

}

resource "aws_iam_policy" "ssm_iam_policy" {
  name = "ssm-qa-policy"
  policy = data.aws_iam_policy_document.worker_iam_policy.json
}
resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role = aws_iam_role.ssm_iam_role.name
  policy_arn = aws_iam_policy.ssm_iam_policy.arn
}
resource "aws_iam_role" "ssm_iam_role" {
  name               = "ssm-qa-role"
  assume_role_policy = data.aws_iam_policy_document.ssm_assume_role.json
}

resource "aws_iam_role_policy_attachment" "ssm_role_policy" {
  role       = aws_iam_role.ssm_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ssm_role_policy2" {
  role       = aws_iam_role.ssm_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}