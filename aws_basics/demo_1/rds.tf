resource "aws_db_subnet_group" "maria_db_subnet" {
  name       = "maria_db_subnet"
  subnet_ids = [aws_subnet.main_subnet_private_id_1.id, aws_subnet.main_subnet_private_id_2.id]

  tags = {
    Name = "maria_db_subnet"
  }
}

resource "aws_db_parameter_group" "maria_db_parameter" {
  name   = "mariadbparameter"
  family = "mariadb10.1"

  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
}

resource "aws_db_instance" "maria_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mariadb"
  engine_version       = "10.1.14"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "root"
  password             = var.RDS_PASSWORD
  parameter_group_name = aws_db_parameter_group.maria_db_parameter.name
  db_subnet_group_name = aws_db_subnet_group.maria_db_subnet.name
  vpc_security_group_ids = [aws_security_group.allow_maria_db.id]
  multi_az = "false"
}
