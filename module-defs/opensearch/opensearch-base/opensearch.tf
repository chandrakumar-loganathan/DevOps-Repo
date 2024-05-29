resource "aws_opensearch_domain" "elasticache" {
  domain_name    = local.domain
  engine_version = var.VERSION

  cluster_config {
    instance_type = var.INSTANCE_TYPE
    dedicated_master_enabled = false
  }
    encrypt_at_rest {
    enabled = true
  }
    node_to_node_encryption {
    enabled = true
  }
  software_update_options {
    auto_software_update_enabled = false
  }
  ebs_options {
    ebs_enabled = true
    volume_size = 100
    volume_type = var.VOLUME_TYPE
  }

  vpc_options {
    subnet_ids = concat (sort(data.terraform_remote_state.vpc.outputs.subnet_1))
    security_group_ids = [aws_security_group.open_search.id]
  }
  access_policies = data.aws_iam_policy_document.elasticache.json
  tags = {
    Domain = local.domain_tag
  }
}




data "aws_iam_policy_document" "elasticache" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions   = ["es:*"]
    resources = ["arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${local.domain}/*"]
  }
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}