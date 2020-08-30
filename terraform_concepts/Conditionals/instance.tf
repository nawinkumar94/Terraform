data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "conditionals" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  # the VPC subnet
  subnet_id = var.ENV == "prod" ? module.vpc-prod.public_subnets[0]:module.vpc-dev.public_subnets[0]
  # the security group
  security_groups = [var.ENV == "prod" ? aws_security_group.allow_prod_ssh.id : aws_security_group.allow_dev_ssh.id]
  # the public key
  key_name = aws_key_pair.mykey.key_name
}
