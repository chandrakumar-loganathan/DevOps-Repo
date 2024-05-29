
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
                "php-fpm",
                "-R"
            ],
            "environment": [],
            "mountPoints": [
                {
                    "sourceVolume": "log_volumes",
                    "containerPath": "/var/www/magento"
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
        },
        {
            "name": local.nginx_container,
            "image": format("%s:latest",aws_ecr_repository.nginx_ecr.repository_url),
            "cpu": var.NGINX_CPU,
            "memory": var.NGINX_MEMORY,
            "memoryReservation": var.NGINX_MEMORY_RESERVATION,
            "links": [
                "${local.php_container}:php"
            ],
            "portMappings": [
                {
                    "name": "nginx-port-mapping",
                    "containerPort": 8080,
                    "hostPort": 0,
                    "protocol": "tcp"
                }
            ],
            "essential": true,
            "environment": [],
            "mountPoints": [
                {
                    "sourceVolume": "log_volumes",
                    "containerPath": "/var/www/magento"
                }
            ],
            "volumesFrom": [],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-create-group": "true",
                    "awslogs-group":  local.nginx_log,
                    "awslogs-region": var.AWS_REGION,
                    "awslogs-stream-prefix": "ecs"
                }
            }
        },
         {
            "name": local.varnish_container,
            "image": format("%s:latest",aws_ecr_repository.varnish_ecr.repository_url),
            "cpu": var.VARSNISH_CPU,
            "memory": var.VARNISH_MEMORY,
            "memoryReservation": var.VARNISH_MEMORY_RESERVATION,
            "links": [
                "${local.nginx_container}:nginx-server"
            ],
            "portMappings": [
                {
                    "name": "varnish-port-mapping",
                    "containerPort": 80,
                    "hostPort": 0,
                    "protocol": "tcp"
                }
            ],
            "essential": false,
            "environment": [],
            "mountPoints": [],
            "volumesFrom": [],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-create-group": "true",
                    "awslogs-group": local.varnish_log,
                    "awslogs-region": var.AWS_REGION,
                    "awslogs-stream-prefix": "ecs"
                }
            }
        }
    ]
  )
}