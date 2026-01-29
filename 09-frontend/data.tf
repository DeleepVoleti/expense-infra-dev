data "aws_ssm_parameter" "public_subnet_ids" {
   name = "/${var.project_name}/${var.env}/public_subnet_ids"
}

data "aws_ssm_parameter" "frontend_sg_id" {
   name = "/${var.project_name}/${var.env}/frontend_sg_id"
}

data "aws_ami" "ami_from_ds" {
    most_recent = true
    owners = ["973714476881"]
    
    filter {
        name = "name"
        values = ["RHEL-9-DevOps-Practice"]
    }
}

data "aws_ssm_parameter" "vpc_id" {
    name = "/${var.project_name}/${var.env}/vpc_id"
}

data "aws_ssm_parameter" "web_alb_listener_https_arn" {
    name = "/${var.project_name}/${var.env}/web_alb_listner_https_arn"
}

data "aws_ssm_parameter" "web_alb_listener_http_arn" {
    name = "/${var.project_name}/${var.env}/web_alb_listner_http_arn"
}