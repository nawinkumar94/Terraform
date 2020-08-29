# Creating the Group
resource "aws_iam_group" "admin_terraform" {
  name = "admin_terraform"
}

# Attaching the policy to group
resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  groups     = [aws_iam_group.admin_terraform.name]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Creating the IAM user1
resource "aws_iam_user" "admin_user1" {
  name = "adminuser1"
}

# Creating the IAM user2
resource "aws_iam_user" "admin_user2" {
  name = "adminuser2"
}

# Adding the users to the group
resource "aws_iam_group_membership" "example" {
  name = "Users Group"
  users = [aws_iam_user.admin_user1.name, aws_iam_user.admin_user2.name]
  group = aws_iam_group.admin_terraform.name
}
