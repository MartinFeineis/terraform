resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name   = "orgVPC"
    Module = "Organizations"
  }
}

output "accOut" {
	value = "Hello Accounts"
}

output "orgModule" {
	value = local.module
}
