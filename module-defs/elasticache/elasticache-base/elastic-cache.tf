resource "aws_security_group" "redis" {
  name = local.sg
  description = "Allow traffic in vpc"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpcid
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elasticache_cluster" "elasticache" {
  cluster_id           = local.cluster_id
  engine               = "redis"
  node_type            = var.NODE_TYPE
  num_cache_nodes      = var.NUMBER_OF_CACHE_ISSUE
  parameter_group_name = aws_elasticache_parameter_group.elasticache_parameter.name
  engine_version       = var.ENGINE_VERSION
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.default.name
  depends_on = [ aws_security_group.redis ]
  security_group_ids   = [aws_security_group.redis.id]
  
}

resource "aws_elasticache_subnet_group" "default" {
  name       = local.elastic_cache_subnet
  subnet_ids = concat (sort(data.terraform_remote_state.vpc.outputs.subnet_1),sort(data.terraform_remote_state.vpc.outputs.subnet_2),sort(data.terraform_remote_state.vpc.outputs.subnet_3))
}

resource "aws_elasticache_parameter_group" "elasticache_parameter" {
  name   = local.redis_parameter
  family = var.REDIS_FAMILY

  parameter {
    name  = "databases"
    value = "100"
  }
}