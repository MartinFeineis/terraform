provider "aws" {
  assume_role {
    role_arn = join("", ["arn:aws:iam::", var.devaccountId, ":role/OrganizationAccountAccessRole"])
  }

  alias  = "develop"
  region = "us-east-1"
}

resource "aws_iam_group" "developer" {
  name     = "Developer"
  provider = aws.develop
}

resource "aws_iam_policy" "dev_policy" {
  name   = "DevPolicy"
  policy = file("${path.module}/localIPPolicy.json")

  provider = aws.develop
}

resource "aws_iam_group_membership" "edvteam" {
  name = "devteammgroup"
  users = [
    aws_iam_user.mydeveloper.name,
  ]

  group    = aws_iam_group.developer.name
  provider = aws.develop
}
resource "aws_iam_group_policy_attachment" "attach_dev_policy" {
  group      = aws_iam_group.developer.name
  policy_arn = aws_iam_policy.dev_policy.arn
  provider   = aws.develop
}

resource "aws_iam_user" "mydeveloper" {
  name     = "mfeineis"
  provider = aws.develop
}

resource "aws_iam_access_key" "mydeveloper_key" {
  user     = aws_iam_user.mydeveloper.id
  provider = aws.develop
}

resource "aws_iam_user_ssh_key" "ssh_key_codecommit" {
  username   = aws_iam_user.mydeveloper.name
  encoding   = "SSH"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 mytest@mydomain.com"
  provider   = aws.develop
}

output "mydeveloper_id" {
  value = aws_iam_access_key.mydeveloper_key.id
}

output "mydeveloper_secret" {
  value     = aws_iam_access_key.mydeveloper_key.secret
  sensitive = true
}
