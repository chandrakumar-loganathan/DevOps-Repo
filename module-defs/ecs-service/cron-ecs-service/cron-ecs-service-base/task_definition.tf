
resource "aws_ecs_task_definition" "tdf" {
  family             = local.tdf_family
  task_role_arn      = aws_iam_role.ecs_task_execution_role.arn
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  requires_compatibilities = [ "EC2" ]
  runtime_platform {
    cpu_architecture = "X86_64"
    operating_system_family = "LINUX"
  }
  network_mode       = "bridge"
  memory             = var.TASK_MEMORY
  volume {
    name = "log_volumes"
    docker_volume_configuration {
      scope = "task"
      driver = "local"
    }
  }

  
  container_definitions = jsonencode(
  [
       {
            "name": local.php_container,
            "image": format("%s:latest",aws_ecr_repository.php_ecr.repository_url),
            "cpu": var.PHP_CPU,
            "memory": var.PHP_MEMORY,
            "memoryReservation": var.PHP_MEMORY_RESERVATION,
            "portMappings": [
                {
                    "name": "php-port-mapping",
                    "containerPort": 9000,
                    "hostPort": 0,
                    "protocol": "tcp"
                }
            ],
            "essential": true,
            "command": [
            ],
              "environment": [{
                "name": "S3_ENV_FILE_PATH",
                "value": "${var.S3_ENV_FILE_PATH}"
                },
                {
                "name":"S3_ENV_FILE_REGION",
                "value":"${var.S3_ENV_FILE_REGION}"
                }
            ],
            "volumesFrom": [],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-create-group": "true",
                    "awslogs-group": local.php_log,
                    "awslogs-region": var.AWS_REGION,
                    "awslogs-stream-prefix": "ecs"
                },
                "secretOptions": []
            }
        }
    ]
  )
}