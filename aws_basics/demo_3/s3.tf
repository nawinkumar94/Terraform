resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-test-nk-040294"
  acl    = "private"

  tags = {
    Name        = "terraform-test-nk-040294"
  }
}
