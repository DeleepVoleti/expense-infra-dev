resource "aws_ssm_parameter" "web_alb_listener_https_arn" {
  name = "/${var.project_name}/${var.env}/web_alb_listener_https_arn"
  type = "String"
  value = aws_lb_listener.web_alb_https.arn
  overwrite = true
}

resource "aws_ssm_parameter" "web_alb_listener_http_arn" {
  name = "/${var.project_name}/${var.env}/web_alb_listener_http_arn"
  type = "String"
  value = aws_lb_listener.web_alb_http.arn
  overwrite = true
}