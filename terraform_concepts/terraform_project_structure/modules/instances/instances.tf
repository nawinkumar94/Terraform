variable "INSTANCE_TYPE"{
  default = "t2.micro"
}

variable "ENV"{

}

variable "PATH_TO_PUBLICKEY"{
  default = "mykey.pub"
}

variable "PUBLIC_SUBNETS"{
  type = list
}

variable "VPC_ID"{

}

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

resource "aws_instance" "instances" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.INSTANCE_TYPE

  subnet_id  = element(var.PUBLIC_SUBNETS,0)

  security_groups  = [aws_security_group.allow_ssh.id]

  key_name = aws_key_pair.mykey.key_name

  tags = {
  Name = "instance-${var.ENV}"
   Environment = var.ENV
 }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh-${var.ENV}"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.VPC_ID

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh-${var.ENV}"
    Environment = "${var.ENV}"
  }
}

resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file("${path.root}/${var.PATH_TO_PUBLICKEY}")
}
