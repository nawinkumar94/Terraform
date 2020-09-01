terraform {
  backend "s3" {
    bucket = "terraform-state-5pblboms"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}
