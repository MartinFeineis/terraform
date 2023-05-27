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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDA1m1ydderfxSrSBZyUMeXTo9n0fDkA9kiYqBUmjjsZs5YZtkXSQkBSREiJTW2qYEBrTSu5pXE5P7y5CB2U1bFtr7sPmUQIhkv1tSUPQusuB1tPat/C/PF3ECJYyebm+UV8pII78M7yB24jqYKCGROkLYhZDnxuTuk27ZG+LveKewmaUR9NJH0abkxVyt0nPCLII8J5Ytshm5HckzZ05pofRrKyhrxXuWh3og/0pHVXPzLpS46/weLJqdb7D2CmOezcoOKWicGLJPiAy4tyhkitxyE9WIlNHjJhoTtRHVXcvVIR5rtSRweIj9OX5mNLu3QhYH4IIJ/8PDRceQafw2N aws develop acc codecommit"
  provider   = aws.develop
}

output "mydeveloper_id" {
  value = aws_iam_access_key.mydeveloper_key.id
}

output "dev_ssh_key" {
  value = aws_iam_user_ssh_key.ssh_key_codecommit.ssh_public_key_id
}

output "mydeveloper_secret" {
  value     = aws_iam_access_key.mydeveloper_key.secret
  sensitive = true
}
