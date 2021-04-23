provider "aws" {
  region     = "us-east-1"
  access_key = var.accesskey
  secret_key = var.secretkey
}

#module "wasserraptor" {
#  source = "./wasserraptor"
#}

#output "main_secret" {
#  value       = module.wasserraptor
#  description = "Secret Key for IAM User in main"
#  sensitive   = true
#}

module "orgs" {
  source = "./accounts"
}

output "orgout" {
  value = module.orgs
}

module "testy" {
  source   = "./testmodule"
  roottags = var.roottags
}

output "paramout" {
  value = module.testy
}

module "bill" {
  source                    = "./billing"
  monthly_billing_threshold = 13
  currency                  = "USD"
  roottags                  = var.roottags
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

#resource "aws_instance" "web" {
#  ami           = "ami-0be2609ba883822ec"
#  instance_type = "t3.micro"
#
#  tags = {
#    Name        = "HelloWorld"
#    terraformed = true
#  }
#}
