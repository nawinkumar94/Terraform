resource "aws_instance" "ec2_example_1"{
  ami = var.AMIS[var.AWS_REGION_NAME]
  instance_type = "t2.micro"
}