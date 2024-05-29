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