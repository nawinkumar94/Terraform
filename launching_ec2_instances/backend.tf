# Need to do aws configure for backend because terrafrom will get the credentials from aws/credentials when configured.
terraform{
  backend  "s3" {
    bucket = "terraform-tf-backup-nk"
    key = "terraform/backup"
    # If region not specified terraform will ask for region during "terraform init"
    region = "ap-south-1"
  }
}
