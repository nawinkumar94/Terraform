resource "aws_instance" "ec2_example_1"{
  ami = var.AMIS[var.AWS_REGION_NAME]
  instance_type = "t2.micro"

  # This will run only in linux or mac not windows, because it is using local-exec not remote-exec
  provisioner "local-exec"{
      command = "echo ${aws_instance.ec2_example_1.private_ip} >> privateip.txt"
  }
}

output "ip"{
  value = aws_instance.ec2_example_1.public_ip
}
