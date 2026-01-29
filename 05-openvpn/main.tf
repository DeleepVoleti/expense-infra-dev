module "vpn" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.env}-vpn"
  key_name = aws_key_pair.vpn.key_name
  instance_type = "t3.micro"
  subnet_id     = local.public_subnet_id
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  ami = data.aws_ami.ami_from_ds.id

  tags = {
    Name = "${var.project_name}-${var.env}-bastion"
    Terraform   = "true"
    Environment = "dev"
  }
}


resource "aws_key_pair" "vpn" {
  key_name   = "dilip-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtw/rZjyRimygtG9qa8MwkH9vysoETWJL//GOztlXKy4pw5YggIu7DVMawbFHNeTmQ7wMyFOwlaUzxtHwV3agveGG0xgczMoGG496vfX4qa1HNtyQ/Un1kR0Z0vQD/Aya98g/sdUoP/LvoJpf+fQIeCvjlNSreuBgAvCYvEeTavgOWsZlAVjq4UG9kGjj6o2I2CF28YEOl+kfmnBKzA034LJCLqy+mV+Qzccn1TAjcdS3u/BvIAwj5qea+MkWaUP/UV9ealwZx3BulbL6b790jZHRxRU3AAdNxvCQ4u0o0ohlq8DD86NOmtrCiPMP8RAYgnmxy3K4v/h9fL0PAPkqB"
}



