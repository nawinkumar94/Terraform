resource "aws_security_group" "allow_ssh" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

    dynamic "ingress" {
      for_each = var.SECURITY_GROUP
      content{
        from_port    = ingress.key
        to_port      = ingress.key
        cidr_blocks  = ingress.value
        protocol     = "tcp"
      }
  }
}
