resource "aws_codebuild_project" "qa-magento-2" {
  name          = var.COMMON_NAME
  description   = var.COMMON_NAME
  build_timeout = 60
  service_role  = var.SERVICE_ROLE_ARN

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
      name  = "WEB_REPO_URL"
      value = var.WEB_REPO_URL
    }

    environment_variable {
      name  = "NGINX_REPO_URL"
      value = var.NGINX_REPO_URL
    }

    environment_variable {
      name  = "VARNISH_REPO_URL"
      value = var.VARNISH_REPO_URL
    }

    environment_variable {
      name  = "WEB_REPO_NAME"
      value = var.WEB_REPO_NAME
    }

    environment_variable {
      name  = "NGINX_REPO_NAME"
      value = var.NGINX_REPO_NAME
    }

    environment_variable {
      name  = "VARNISH_REPO_NAME"
      value = var.VARNISH_REPO_NAME
    }

     environment_variable {
      name  = "S3_ENV_FILE_PATH"
      value = var.S3_ENV_FILE_PATH
    }

    environment_variable {
      name  = "S3_MEDIA_FILE_PATH"
      value = var.S3_MEDIA_FILE_PATH
    }

    environment_variable {
      name  = "WEB_CONTAINER"
      value = var.WEB_CONTAINER
    }

    environment_variable {
      name  = "NGINX_CONTAINER"
      value = var.NGINX_CONTAINER
    }

    environment_variable {
      name  = "VARNISH_CONTAINER"
      value = var.VARNISH_CONTAINER
    }

    environment_variable {
      name  = "REGION"
      value = var.REGION
    }

    environment_variable {
      name  = "REACT_PROJECT_NAME"
      value = var.REACT_PROJECT_NAME
    }

    environment_variable {
      name  = "REACT_APP_BASE_URL"
      value = var.REACT_APP_BASE_URL
    }
    
  }

  source {
    type            = "CODEPIPELINE"
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }

    buildspec = "docker/buildspec.yaml"
  }

  source_version = "master"

  # vpc_config {
  #   vpc_id = var.VPC_ID
  #   subnets = [var.PRIVATE_SUBNET_1]
  #   security_group_ids = [aws_security_group.codepipeline-sg.id]
  # }

  tags = {
    Environment = var.COMMON_NAME
  }
}
