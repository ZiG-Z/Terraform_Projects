resource "aws_iam_role" "myasg-s3-role" {
  name               = "myasg-s3-role"
  assume_role_policy = <<EOF
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

resource "aws_iam_role_policy_attachment" "myasg-s3-role-attach" {
  role       = aws_iam_role.myasg-s3-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_instance_profile" "myasg-s3-role-profile" {
  name = "myasg-s3-role-profile"
  role = aws_iam_role.myasg-s3-role.name
}