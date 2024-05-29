# ELASTIC CONTAINER REGISTRY REPO
resource "aws_ecr_repository" "php_ecr" {
  name                 = local.php_ecr
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
  encryption_configuration {
    encryption_type = "AES256"
    kms_key         = ""
  }
}
