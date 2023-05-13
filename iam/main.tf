resource "aws_iam_user" "work" {
  name = "work"

#  tags = {
#    Name = "WorkUser"
#  }
  tags = merge(var.roottags, var.moduletags, {Name = "WorkUser"})
}

resource "aws_iam_access_key" "workacckey" {
  user = aws_iam_user.work.name
}

resource "aws_iam_user_policy" "work_ro" {
  name = "WorkFAccess"
  user = aws_iam_user.work.name

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

resource "aws_iam_user" "github" {
  name = "example-user"
}

resource "aws_iam_user_policy_attachment" "github_admin_role" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  user       = aws_iam_user.github.name
}

output "paramoutput" {
  value = aws_iam_user.github
}
