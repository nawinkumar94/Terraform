# Terraform
Terraform
#launching_ec2_instances
  This will launch the ec2 instances with output, the output will be the public ip,
  And also provides s3 backend to store terraform.tfstate.backup

#ubuntu_ec2_instances_keypair
  This will create the ec2 instance with ubuntu ami and installs the ngnix scripts in the ec2 instances

#windows_ec2_instaces_keypair
  This will create the ec2 instance with windows ami

#creating_security_group
  This will create the security groups using the data source that gives all the IP's of the mentioned regions,
  Inbound rules will be added for all IP's ,in a security group.

#creating_modules
  Modules are used to use another resource in our resource.
  In this example we have used the resource from the git repository.

#aws_basics
#demo_1
    --> VPC, EC2 with VPC, EBS, RDS
  Commands for RDS in AWS
  --> To connect to EC2
  ssh -i mykey ubuntu@13.126.255.20
  --> install mysql client
  sudo apt-get install mysql-client
  --> To connect to created mysql mariadb(We can get the host name in output.tf)
  mysql -u "user_name" -h "host_name" -p "password"

#demo_2
   ---> creating IAM user
#demo3
   ---> Creating IAM Role
