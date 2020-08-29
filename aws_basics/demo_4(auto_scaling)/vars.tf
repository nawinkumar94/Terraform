variable AWS_REGION{
  default = "ap-south-1"
}

variable PATH_TO_PUBLIC_KEY{
  default = "mykey.pub"
}

variable PATH_TO_PRIVATE_KEY{
  default = "mykey"
}

variable AMIS{
  type = map(string)
  default = {
    ap-south-1 = "ami-04d8d4462ae1ae813"
    ap-northeast-1 = "ami-036cb77005c69fbe0"
    ap-east-1 = "ami-f19cdf80"
  }
}
