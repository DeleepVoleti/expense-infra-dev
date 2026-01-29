module "db" {
    source = "git::https://github.com/DeleepVoleti/terraform-sg-module.git?ref=main"
    vpc_id = data.aws_ssm_parameter.vpc_id.value 
    sg_name = "db"
    project_name = var.project_name 
    env = var.env
}

module "app_alb" {
    source = "git::https://github.com/DeleepVoleti/terraform-sg-module.git?ref=main"
    vpc_id = data.aws_ssm_parameter.vpc_id.value 
    sg_name = "app_alb"
    project_name = var.project_name 
    env = var.env 
}

module "web_alb" {
    source = "git::https://github.com/DeleepVoleti/terraform-sg-module.git?ref=main"
    vpc_id = data.aws_ssm_parameter.vpc_id.value 
    sg_name = "web_alb"
    project_name = var.project_name 
    env = var.env 
}


module "vpn" {
    source = "git::https://github.com/DeleepVoleti/terraform-sg-module.git?ref=main"
    vpc_id = data.aws_ssm_parameter.vpc_id.value 
    sg_name = "vpn"
    project_name = var.project_name 
    env = var.env
    ingress_rules = var.vpn_sg_rules
}

module "backend" {
    source = "git::https://github.com/DeleepVoleti/terraform-sg-module.git?ref=main"
    vpc_id = data.aws_ssm_parameter.vpc_id.value 
    sg_name = "backend"
    project_name = var.project_name 
    env = var.env
}

module "frontend" {
    source = "git::https://github.com/DeleepVoleti/terraform-sg-module.git?ref=main"
    vpc_id = data.aws_ssm_parameter.vpc_id.value 
    sg_name = "frontend"
    project_name = var.project_name 
    env = var.env
}

module "bastion" {
    source = "git::https://github.com/DeleepVoleti/terraform-sg-module.git?ref=main"
    vpc_id = data.aws_ssm_parameter.vpc_id.value 
    sg_name = "bastion"
    project_name = var.project_name 
    env = var.env
}

# public_to_vpn all rules kept inside module vpn

#app_alb ##################################################################
resource "aws_security_group_rule" "vpn_to_app_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.app_alb.sg_id
}

# web_alb ##################################################################
resource "aws_security_group_rule" "public_to_web_alb_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.web_alb.sg_id
}

resource "aws_security_group_rule" "public_to_web_alb_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.web_alb.sg_id
}


#db #########################################################################
resource "aws_security_group_rule" "backend_to_db" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.backend.sg_id
  security_group_id = module.db.sg_id
}

resource "aws_security_group_rule" "bastion_to_db" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.db.sg_id
}

resource "aws_security_group_rule" "vpn_to_db" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.db.sg_id
}
# backend #####################################################################
resource "aws_security_group_rule" "app_alb_to_backend" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.app_alb.sg_id
  security_group_id = module.backend.sg_id
}

resource "aws_security_group_rule" "bastion_to_backend" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.backend.sg_id
}

resource "aws_security_group_rule" "vpn_to_backend_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.backend.sg_id
}

resource "aws_security_group_rule" "vpn_to_backend_http" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.backend.sg_id
}
#### frontend ###########################################################################################
# resource "aws_security_group_rule" "public_to_frontend" {  
#   type              = "ingress"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = module.frontend.sg_id
# }                                                          

resource "aws_security_group_rule" "bastion_to_frontend" { 
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.frontend.sg_id
}

resource "aws_security_group_rule" "web_alb_to_frontend" { 
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.web_alb.sg_id
  security_group_id = module.frontend.sg_id
}

resource "aws_security_group_rule" "vpn_to_frontend" { 
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.frontend.sg_id
}

resource "aws_security_group_rule" "vpn_to_frontend_80" { 
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.frontend.sg_id
}
# bastion ###########################################################################

resource "aws_security_group_rule" "public_to_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}
