module "vpc" {
    source = "git::https://github.com/DeleepVoleti/aws-terraform-vpc-module.git?ref=main"
    common_tags = var.common_tags
    project_name = var.project_name
    env = var.env
    public_subnet_cidrs = ["10.0.1.0/24" , "10.0.2.0/24"]
    private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
    db_subnet_cidrs = ["10.0.21.0/24", "10.0.22.0/24"]
    is_peering_req = false
    cidr = "10.0.0.0/16"
    
    
}