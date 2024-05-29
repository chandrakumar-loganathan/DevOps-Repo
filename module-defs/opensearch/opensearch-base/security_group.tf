resource "aws_security_group" "open_search" {
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