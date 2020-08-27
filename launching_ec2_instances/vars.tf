variable "AWS_ACCESS_KEY"  {

}
variable "AWS_SECRET_KEY"  {

}
variable "AWS_REGION_NAME" {
  default = "ap-south-1"
}

variable "AMIS"  {
  type = map(string)
  default = {
    ap-south-1 = "ami-0a780d5bac870126a"
    us-east-1 = "ami-0761dd91277e34178"
    us-east-2 = "ami-0f4aeaec5b3ce9152"

  }
}
