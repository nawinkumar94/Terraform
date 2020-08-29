resource "aws_instance" "instance" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  subnet_id = aws_subnet.main_subnet_public_id_1.id

  key_name = aws_key_pair.mykey.key_name

  iam_instance_profile  = aws_iam_instance_profile.ec2_s3_profile.name

}
