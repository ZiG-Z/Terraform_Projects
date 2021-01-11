resource "aws_iam_group" "administrators" {
  name = "administrators"
}

resource "aws_iam_policy_attachment" "administrators-attach" {
  name       = "administrators-attach"
  groups     = [aws_iam_group.administrators.name]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "admin1" {
  name = "admin1"
}

resource "aws_iam_user" "admin2" {
  name = "admin2"
}

resource "aws_iam_group_membership" "administrators-users" {
  name  = "administrators-users"
  users = [aws_iam_user.admin1.name, aws_iam_user.admin2.name]
  group = aws_iam_group.administrators.name
}

resource "aws_iam_access_key" "admin1" {
  user = aws_iam_user.admin1.name
}

resource "aws_iam_access_key" "admin2" {
  user = aws_iam_user.admin2.name
}

output "secret_key1" {
  value = aws_iam_access_key.admin1.secret
}

output "secret-key2" {
  value = aws_iam_access_key.admin2.secret
}