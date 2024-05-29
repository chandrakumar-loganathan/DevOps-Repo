resource "aws_codebuild_project" "build" {
  name          = local.build
  description   = var.COMMON_NAME
  badge_enabled = false
  build_timeout = 60
  service_role  = var.SERVICE_ROLE_ARN
  encryption_key = ""
  queued_timeout     = 480
  project_visibility = "PRIVATE"
  lifecycle { ignore_changes = [project_visibility] }

  artifacts {
    type = "CODEPIPELINE"
  }
  
  cache {
    type     = "LOCAL"
    modes = [
      "LOCAL_DOCKER_LAYER_CACHE"
    ]
  }

  environment {
    privileged_mode             = true
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "ECR_QUERY"
      value = var.ECR_QUERY
    }

    environment_variable {
      name  = "CRON_REPO_URL"
      value = aws_ecr_repository.php_ecr.repository_url
    }

    environment_variable {
      name  = "CRON_REPO_NAME"
      value = aws_ecr_repository.php_ecr.name
    }

    environment_variable {
      name  = "S3_MEDIA_FILE_PATH"
      value = var.S3_MEDIA_FILE_PATH
    }

    environment_variable {
      name  = "CRON_CONTAINER"
      value = local.php_container
    }
    environment_variable {
      name  = "REGION"
      value = var.REGION
    }
    environment_variable {
      name = "DOCKER_PASSWORD"
      value = var.DOCKER_PASSWORD
    }
    environment_variable {
      name = "DOCKER_USERNAME"
      value = var.DOCKER_USERNAME
    }
  }

  source {
    type            = "CODEPIPELINE"
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }

    buildspec = var.BUILD_SPEC_PATH
  }
  source_version = var.BRANCH_NAME
}
