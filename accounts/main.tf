resource "aws_organizations_organization" "martinorg" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
  ]

  feature_set = "ALL"
}

resource "aws_organizations_account" "aolcom" {
  name  = "aol-test-account"
  email = "martifein@aol.com"
}

output "accOut" {
	value = "Hello Accounts"
}
