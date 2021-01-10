resource "aws_iam_user" "iam_wrp" {
  name = "wasserraptor"

  tags = {
    Name        = "IAMWasserRaptor"
    terraformed = true
  }
}

resource "aws_iam_access_key" "iam_ackey_wrp" {
  user = aws_iam_user.iam_wrp.name
}

resource "aws_iam_policy" "iam_policy_wrp" {
  name        = "WasserraptorPolicy"
  description = "Policy for Wasserraptor account to s3 bucket"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action": "s3:ListAllMyBuckets",
        "Resource": "arn:aws:s3:::*"
    },
    {
        "Effect": "Allow",
        "Action": [
            "s3:ListBucket",
            "s3:GetBucketLocation"
        ],
        "Resource": "arn:aws:s3:::wasserraptorde"
    },
    {
        "Effect": "Allow",
        "Action": [
            "s3:PutObject",
            "s3:PutObjectAcl",
            "s3:GetObject",
            "s3:GetObjectAcl",
            "s3:DeleteObject"
        ],
        "Resource": "arn:aws:s3:::wasserraptorde/*"
    }
  ]
}
EOF
}

resource "aws_iam_user_policy_attachment" "iam_plcy_att_wrp" {
  user      = aws_iam_user.iam_wrp.name
  policy_arn = aws_iam_policy.iam_policy_wrp.arn
}
