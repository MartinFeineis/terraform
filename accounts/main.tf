resource "aws_organizations_account" "yahoode" {
  name  = "yahoo-test-account"
  email = "martin.feineis@yahoo.de"
}

output "accOut" {
	value = "Hello Accounts"
}
