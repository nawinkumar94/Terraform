resource "aws_launch_configuration" "auto_scale_conf" {
  name          = "auto-scale-config"
  image_id      = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  key_name = aws_key_pair.mykey.key_name
  security_groups =[aws_security_group.allow_ssh.id]
  user_data       = "#!/bin/bash\napt-get update\napt-get -y install net-tools nginx\nMYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'this is: '$MYIP > /var/www/html/index.html"
  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "auto_scale_grp" {
  name                      = "auto-scale-grp"
  max_size                  = 3
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  load_balancers            = [aws_elb.elb.name]
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.auto_scale_conf.name
  vpc_zone_identifier       = [aws_subnet.main_subnet_public_id_1.id, aws_subnet.main_subnet_public_id_2.id]

}
