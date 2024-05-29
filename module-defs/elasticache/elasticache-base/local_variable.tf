locals {
  cluster_id=format("%s-cluster",var.COMMON_NAME)
  elastic_cache_subnet=format("%s-subnet",var.COMMON_NAME)
  sg=format("%s-elasticache-sg",var.COMMON_NAME)
  redis_parameter=format("%s-redis-parameter",var.COMMON_NAME)
}