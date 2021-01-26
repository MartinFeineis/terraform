resource "aws_iam_user" "iam_ecr_pusher" {
  name = "ecrpusher"
  
tags = merge(
    var.moduletags
  , var.roottags)
}

resource "aws_iam_access_key" "iam_ackey_wrp" {
  user = aws_iam_user.iam_ecr_pusher.name
}

resource "aws_iam_policy" "iam_polics_ecrpusher" {
  name        = "ECR-Pusher_policy"
  description = "Policy to push ECR Repositories"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action":  [ "sts:AssumeRoles", "iam:ListRoles"],
        "Resource": "*"
    }
  ]
}
EOF
}
