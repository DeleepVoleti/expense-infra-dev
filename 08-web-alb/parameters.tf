resource "aws_ssm_parameter" "aws_lb_listener_https_arn" {
  name = "/${var.project_name}/${var.env}/web_alb_listener_https_arn"
  type = string
  value = aws_lb_listener.web_alb_https.arn
}

resource "aws_ssm_parameter" "aws_lb_listener_http_arn" {
  name = "/${var.project_name}/${var.env}/web_alb_listener_http_arn"
  type = string
  value = aws_lb_listener.web_alb_http.arn
}