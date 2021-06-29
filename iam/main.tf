resource "aws_iam_user" "contino" {
  name = "contino"

  tags = {
    Name = "WorkUser"
  }
}

resource "aws_iam_access_key" "continoacckey" {
  user = aws_iam_user.contino.name
}

resource "aws_iam_user_policy" "contino_ro" {
  name = "WorkFAccess"
  user = aws_iam_user.contino.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
