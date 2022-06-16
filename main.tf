provider "aws" {
  region     = "us-east-1"
  access_key = var.accesskey
  secret_key = var.secretkey
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.development.id}:role/OrganizationAccountAccessRole"
  }

  alias  = "develop"
  region = "us-east-1"
}

module "bill" {
  source                    = "./billing"
  monthly_billing_threshold = 13
  currency                  = "USD"
  roottags                  = var.roottags
}

module "scps" {
  source      = "./scps"
  target_id = aws_organizations_organizational_unit.dev_org.id
  region_lockdown = [
  "eu-north-1", "ap-south-1", "eu-west-3", "eu-west-2", "eu-west-1", "ap-northeast-3", "ap-northeast-2", "ap-northeast-1", "sa-east-1", "ca-central-1", "ap-southeast-1", "ap-southeast-2", "eu-central-1", "us-east-2", "us-west-1", "us-west-2" ]
}

resource "aws_organizations_organizational_unit" "dev_org" {
  name      = "development"
  parent_id = "r-7ze0"
}

resource "aws_organizations_account" "development" {
  name  = "development-account"
  email = "martin.fe@web.de"
  parent_id = aws_organizations_organizational_unit.dev_org.id
}

resource "aws_iam_group" "developer" {
  name = "Developer"
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

  group = aws_iam_group.developer.name
  provider = aws.develop
}
resource "aws_iam_group_policy_attachment" "attach_dev_policy" {
  group      = aws_iam_group.developer.name
  policy_arn = aws_iam_policy.dev_policy.arn

  provider = aws.develop
}

resource "aws_iam_user" "mydeveloper" {
    name = "mfeineis"
  provider = aws.develop
}
