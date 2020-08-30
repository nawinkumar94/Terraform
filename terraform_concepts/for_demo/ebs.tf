
resource "aws_ebs_volume" "example" {
  availability_zone = "eu-west-1a"
  size              = 8

  tags = {for k,v in merge({Name = "EBS"},var.project_tags) : lower(k)=>lower(v)}
}
