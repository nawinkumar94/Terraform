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

resource "aws_instance" "jenkins_instance" {
  ami           = data.aws_ami.ubuntu.id

  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids  = [aws_security_group.jenkins-security-groups.id]

  # the public SSH key
  key_name = aws_key_pair.mykey.key_name

  # IAM Role
  iam_instance_profile = aws_iam_instance_profile.jenkins_role.name

  # user data
  user_data = data.template_cloudinit_config.cloudinit-jenkins.rendered

}

### EBS volume ###
resource "aws_ebs_volume" "jenkins_volume" {
  availability_zone = "ap-south-1a"
  size              =  20
  type              = "gp2"
  tags = {
    Name = "jenkins-data"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = var.INSTANCE_DEVICE_NAME
  volume_id   = aws_ebs_volume.jenkins_volume.id
  instance_id = aws_instance.jenkins_instance.id
  skip_destroy = true
}

resource "aws_instance" "app_instance" {
  count         = var.APP_INSTANCE_COUNT
  ami           = var.APP_INSTANCE_AMI
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.app-security-groups.id]

  # the public SSH key
  key_name = aws_key_pair.mykey.key_name
}


### SSH Key pair ###
resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

### S3 bucket ###
resource "aws_s3_bucket" "terraform-state" {
  bucket = "terraform-state-${random_string.random.result}"
  acl    = "private"

  tags = {
    Name = "Terraform state"
  }
}

resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}

### IAM Role for jenkins ###
resource "aws_iam_role" "jenkins_role" {
  name = "jenkins_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    tag-key = "jenkins-role"
  }
}

### Instance profile for jenkins ###
resource "aws_iam_instance_profile" "jenkins_role" {
  name = "jenkins_role"
  role = aws_iam_role.jenkins_role.name
}

### IAM Policy ###
resource "aws_iam_policy" "jenkins_policy" {
  name        = "jenkins_policy"
  description = "Policy for jenkins"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
