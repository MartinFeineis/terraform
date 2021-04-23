resource "aws_organizations_account" "aolcom" {
  name  = "aol-test-account"
  email = "martifein@aol.com"
}

output "accOut" {
	value = "Hello Accounts"
}
