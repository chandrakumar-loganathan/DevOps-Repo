resource "aws_launch_template" "lt" {
  name     = local.lt
  image_id = var.ECS_AMI
  iam_instance_profile {
    arn = aws_iam_instance_profile.iam_instance_profile.arn
  }
  vpc_security_group_ids = [aws_security_group.sg.id]
  instance_type          = var.INSTANCE_TYPE
  update_default_version = true
  block_device_mappings {
    # need to consider at the time of ami change
    device_name = "/dev/xvda"
    ebs {
      volume_size           = 100
      delete_on_termination = true
      encrypted             = false
      volume_type           = "gp2"
    }
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = local.lt_tag
    }
  }
  monitoring {
    enabled = false
  }
  user_data = base64encode(<<-EOF
      #!/bin/bash
      echo ECS_CLUSTER=${data.terraform_remote_state.module_ecs.outputs.cluster} >> /etc/ecs/ecs.config;
    EOF 
  )
}