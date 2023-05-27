provider "aws" {
  region     = "us-east-1"
  access_key = var.accesskey
  secret_key = var.secretkey
  profile    = "manager"
}


module "bill" {
  source                    = "./billing"
  monthly_billing_threshold = 13
  currency                  = "USD"
  roottags                  = var.roottags
}

module "users" {
  source   = "./iam"
  roottags = var.roottags
}

module "scps" {
  source    = "./scps"
  target_id = aws_organizations_organizational_unit.dev_org.id
  region_lockdown = [
  "eu-north-1", "ap-south-1", "eu-west-3", "eu-west-2", "eu-west-1", "ap-northeast-3", "ap-northeast-2", "ap-northeast-1", "sa-east-1", "ca-central-1", "ap-southeast-1", "ap-southeast-2", "eu-central-1", "us-east-2", "us-west-1", "us-west-2"]
}

resource "aws_organizations_organizational_unit" "dev_org" {
  name      = "development"
  parent_id = "r-7ze0"
}

resource "aws_organizations_account" "development" {
  name      = "development-account"
  email     = "martin.fe@web.de"
  parent_id = aws_organizations_organizational_unit.dev_org.id
}

module "develop_account" {
  source = "./devaccount"
  #roottags                  = var.roottags
  devaccountId = aws_organizations_account.development.id
}

output "dev_account" {
  value     = module.develop_account
  sensitive = true
}

module "amplify" {
  source = "./amplify"
  #roottags                  = var.roottags
  devaccountId = aws_organizations_account.development.id
}

output "amplify" {
  value     = module.develop_account
  sensitive = true
}
