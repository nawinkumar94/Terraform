variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "AWS_REGION" {
  default = "ap-south-1"
}

variable "WIN_AMIS" {
  type = map(string)
  default = {
    ap-south-1 = "ami-0618f7eae2b9efc80"
    us-west-2 = "ami-0d926c3fdb08c880a"
    us-west-1 = "ami-0f5739a63b6e683bf"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "INSTANCE_USERNAME" {
  default = "Terraform"
}

variable "INSTANCE_PASSWORD" {
}
