data "aws_ip_ranges" "asia_ec2"{
  regions = ["ap-south-1","us-east-1"]
  services = ["ec2"]
}

resource "aws_security_group" "from_asia"{
  name = "from_asia"

  ingress {
    from_port = "443"
    to_port = "443"
    protocol = "tCP"
    # Since security groups have restrictions about 60 inbound and 60 outbound rules
    cidr_blocks = slice(data.aws_ip_ranges.asia_ec2.cidr_blocks,0,60)
  }
  tags = {
    CREATE_DATE = data.aws_ip_ranges.asia_ec2.create_date
    SYNC_TOKEN = data.aws_ip_ranges.asia_ec2.sync_token
  }
}
