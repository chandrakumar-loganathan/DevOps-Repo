output "http_arn" {
  value = aws_lb_listener.http_listener.arn
}
output "https_arn" {
  value = aws_lb_listener.https_listener.arn
}
output "load_balancer_arn" {
  value = aws_lb.lb.arn
}