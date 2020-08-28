resource "aws_instance" "instance" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  subnet_id = aws_subnet.main_subnet_public_id_1.id

  key_name = aws_key_pair.mykey.key_name

}

resource "aws_ebs_volume" "new_volume_1" {
  availability_zone = "ap-south-1a"
  size              = 20
  tags = {
    Name = "new_volume_1"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.new_volume_1.id
  instance_id = aws_instance.instance.id
}
