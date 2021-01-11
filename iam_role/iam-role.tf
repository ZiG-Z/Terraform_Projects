resource "aws_iam_role" "s3-mybkt-role" {
  name               = "s3-mybkt-role"
  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

resource "aws_iam_instance_profile" "s3-mybkt-role-instanceprofile" {
  name = "s3-mybkt-role"
  role = aws_iam_role.s3-mybkt-role.name
}

resource "aws_iam_policy_attachment" "s3-mybkt-role-attach" {
  name       = "s3-mybkt-role-attach"
  roles      = [aws_iam_role.s3-mybkt-role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}