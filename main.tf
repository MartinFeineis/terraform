provider "aws" {
  region     = "us-east-1"
  access_key = var.accesskey
  secret_key = var.secretkey
}

#module "wasserraptor" {
#  source = "./wasserraptor"
#}

module "testy" {
  source   = "./testmodule"
  roottags = var.roottags
}

module "bill" {
  source                    = "./billing"
  monthly_billing_threshold = 13
  currency                  = "USD"
  roottags                  = var.roottags
}

module "scps" {
  source      = "./scps"
}

#module "eksaws" {
#  source      = "./eksaws"
#  roottags    = var.roottags
#  eksdeployer = var.eksdeployer
#}

module "registries" {
  source   = "./registries"
  regnames = var.ecr_names
  roottags = var.roottags
}

output "main_secret" {
  value       = module.wasserraptor
  description = "Secret Key for IAM User in main"
  sensitive   = true
}

output "paramout" {
  value = module.testy
}

#resource "aws_instance" "web" {
#  ami           = "ami-0be2609ba883822ec"
#  instance_type = "t3.micro"
#
#  tags = {
#    Name        = "HelloWorld"
#    terraformed = true
#  }
#}
