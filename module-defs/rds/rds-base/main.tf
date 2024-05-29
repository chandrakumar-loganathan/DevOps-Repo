resource "aws_rds_cluster_instance" "rds" {
    identifier             = var.DB_NAME
    cluster_identifier     = aws_rds_cluster.rds.cluster_identifier
    engine                 = "aurora-mysql"
    engine_version         = var.DB_ENGINE_VERSION
    instance_class         = var.DB_ENGINE_CLASS
    db_subnet_group_name   = aws_db_subnet_group.subnet.name
  }

resource "aws_security_group" "rds" {
  name = local.sg
  description = "Allow rds in vpc"
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

resource "aws_rds_cluster" "rds" {
  cluster_identifier      = var.DB_NAME
  engine                  = "aurora-mysql"
  engine_version          = var.DB_ENGINE_VERSION
  database_name           = var.MASTER_DB_NAME
  master_username         = var.USER_NAME
  master_password         = var.PASSWORD
  db_subnet_group_name    = aws_db_subnet_group.subnet.name
  vpc_security_group_ids  = [aws_security_group.rds.id]
  skip_final_snapshot     = true  
  storage_encrypted       = true
}

resource "aws_db_subnet_group" "subnet" {
  name       = local.db_subnet_group_name
  subnet_ids = concat (sort(data.terraform_remote_state.vpc.outputs.subnet_1),sort(data.terraform_remote_state.vpc.outputs.subnet_2),sort(data.terraform_remote_state.vpc.outputs.subnet_3))
  tags = {
    Name = local.db_subnet_group_tag
  }
}