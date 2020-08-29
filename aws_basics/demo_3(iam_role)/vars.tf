variable AWS_REGION{
  default = "ap-south-1"
}
 variable AWS_PUBLIC_KEY{
  default = "mykey.pub"
 }
 variable AWS_PRIVATE_KEY{
  default = "mykey"
 }
 variable "AWS_ACCESS_KEY"{

 }
 variable "AWS_SECRET_KEY"{

 }
variable AMIS{
  type = map(string)
  default = {
  ap-south-1 = "ami-04d8d4462ae1ae813"
  ap-northeast-1 = "ami-036cb77005c69fbe0"
  ap-east-1 = "ami-f19cdf80"
  }
}
