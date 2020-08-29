output "instance" {
  value = aws_instance.instance.public_ip
}

output "rdb"{
  value = aws_db_instance.maria_db.endpoint
}
