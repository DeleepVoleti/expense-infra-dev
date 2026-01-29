module "bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.env}-bastion"

  instance_type = "t3.micro"
  subnet_id     = local.public_subnet_id
  vpc_security_group_ids = [data.aws_ssm_parameter.bastion_sg_id.value]
  ami = data.aws_ami.ami_from_ds.id
  user_data = file("mysql.sh")

  tags = {
    Name = "${var.project_name}-${var.env}-bastion"
    Terraform   = "true"
    Environment = "dev"
  }
}


