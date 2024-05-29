# EC2-TARGET GROUP
resource "aws_lb_target_group" "tg" {
  name                 = local.web_alb_tg
  target_type          = "instance"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = data.terraform_remote_state.vpc.outputs.vpcid
  deregistration_delay = 30
  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 60
    matcher             = "200"
    path                = "/health_check.php"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 59
    unhealthy_threshold = 10
  }
  ip_address_type                    = "ipv4"
  lambda_multi_value_headers_enabled = false
  load_balancing_algorithm_type      = "round_robin"
  load_balancing_cross_zone_enabled  = "use_load_balancer_configuration"
  name_prefix                        = null
  preserve_client_ip                 = null
  protocol_version                   = "HTTP1"
  proxy_protocol_v2                  = false
  slow_start                         = 0
  stickiness {
    cookie_duration = 86400
    cookie_name     = ""
    enabled         = false
    type            = "lb_cookie"
  }
}



resource "aws_lb_listener_rule" "web_alb_rule_port_80" {
  listener_arn = data.terraform_remote_state.lb.outputs.http_arn
  priority     = var.ALB_LISTENER_PORT_80_PRIORITY
  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
    redirect {
      protocol    = "HTTPS"
      port        = "443"
      host        = "#{host}"
      path        = "/#{path}"
      query       = "#{query}"
      status_code = "HTTP_301"
    }
  }
  condition {
    host_header {
      values = ["${var.ALB_LISTENER_RULE_HOST_HEADER}"]
    }
  }
}

resource "aws_lb_listener_rule" "web_alb_rule_port_443" {
  listener_arn = data.terraform_remote_state.lb.outputs.https_arn
  priority     = var.ALB_LISTENER_PORT_443_PRIORITY
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
  condition {
    host_header {
      values = ["${var.ALB_LISTENER_RULE_HOST_HEADER}"]
    }
  }
}