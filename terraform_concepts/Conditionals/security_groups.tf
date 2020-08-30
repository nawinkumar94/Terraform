resource "aws_security_group" "allow_prod_ssh" {
  name        = "allow_prod_ssh"
  description = "Allow SSH inbound traffic for prod env"
  vpc_id      = module.vpc-prod.vpc_id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["157.49.210.52/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_prod_ssh"
  }
}

resource "aws_security_group" "allow_dev_ssh" {
  name        = "allow_dev_ssh"
  description = "Allow SSH inbound traffic for dev env"
  vpc_id      = module.vpc-dev.vpc_id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["157.49.210.52/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_dev_ssh"
  }
}
