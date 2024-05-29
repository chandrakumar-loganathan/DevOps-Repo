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

# ECR REPO LIFECYCLE POLICY
resource "aws_ecr_lifecycle_policy" "php_repo_lifecycle" {
  repository = aws_ecr_repository.php_ecr.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Set the image's max count of 5",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}



# ELASTIC CONTAINER REGISTRY REPO
resource "aws_ecr_repository" "nginx_ecr" {
  name                 = local.nginx_ecr
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
  encryption_configuration {
    encryption_type = "AES256"
    kms_key         = ""
  }
}

# ECR REPO LIFECYCLE POLICY
resource "aws_ecr_lifecycle_policy" "nginx_repo_lifecycle" {
  repository = aws_ecr_repository.nginx_ecr.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Set the image's max count of 5",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

resource "aws_ecr_repository" "varnish_ecr" {
  name                 = local.varnish_ecr
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
  encryption_configuration {
    encryption_type = "AES256"
    kms_key         = ""
  }
}

# ECR REPO LIFECYCLE POLICY
resource "aws_ecr_lifecycle_policy" "varnish_repo_lifecycle" {
  repository = aws_ecr_repository.varnish_ecr.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Set the image's max count of 5",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}