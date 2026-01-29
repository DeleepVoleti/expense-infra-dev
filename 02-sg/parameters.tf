resource "aws_ssm_parameter" "db_sg_id" {
    name = "/${var.project_name}/${var.env}/db_sg_id"
    type = "String"
    value = module.db.sg_id
}

resource "aws_ssm_parameter" "backend_sg_id" {
    name = "/${var.project_name}/${var.env}/backend_sg_id"
    type = "String"
    value = module.backend.sg_id
}

resource "aws_ssm_parameter" "web_alb_sg_id" {
    name = "/${var.project_name}/${var.env}/web_alb_sg_id"
    type = "String"
    value = module.web_alb.sg_id
}

resource "aws_ssm_parameter" "frontend_sg_id" {
    name = "/${var.project_name}/${var.env}/frontend_sg_id"
    type = "String"
    value = module.frontend.sg_id
}

resource "aws_ssm_parameter" "bastion_sg_id" {
    name = "/${var.project_name}/${var.env}/bastion_sg_id"
    type = "String"
    value = module.bastion.sg_id
}

resource "aws_ssm_parameter" "vpn_sg_id" {
    name = "/${var.project_name}/${var.env}/vpn_sg_id"
    type = "String"
    value = module.vpn.sg_id
}

resource "aws_ssm_parameter" "app_alb_sg_id" {
    name = "/${var.project_name}/${var.env}/app_alb_sg_id"
    type = "String"
    value = module.app_alb.sg_id
}