provider "aws" {
  assume_role {
    role_arn = join("" , ["arn:aws:iam::", var.devaccountId, ":role/OrganizationAccountAccessRole"])
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
  user = aws_iam_user.mydeveloper.id
  provider = aws.develop
}

output "mydeveloper_id" {
  value = aws_iam_access_key.mydeveloper_key.id
}

output "mydeveloper_secret" {
  value     = aws_iam_access_key.mydeveloper_key.secret
  sensitive = true
}