resource "aws_lb" "lb" {
  name               = local.lb
  load_balancer_type =  var.LOAD_BALANCER_TYPE
  subnets            = data.terraform_remote_state.vpc.outputs.public_subnet
  security_groups    = [aws_security_group.sg.id]
  enable_cross_zone_load_balancing = true
}

resource "aws_security_group" "sg" {
  name        = local.sg
  description = "Allow Traffic"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpcid
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = local.sg_tag
  }
}

data "terraform_remote_state" "vpc" {
  # BACKEND-S3

  backend = "s3"
  config = {
    # Replace this with your bucket name!
    bucket = var.S3_BUCKET_VPC
    key    = var.S3_BUCKET_PATH_VPC
    region = var.S3_BUCKET_AWS_REGION_VPC
  }
}
