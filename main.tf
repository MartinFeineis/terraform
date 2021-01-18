provider "aws" {
  region     = "us-east-1"
  access_key = var.accesskey
  secret_key = var.secretkey
}

module "wasserraptor" {
  source = "./wasserraptor"
}

module "testy" {
  source     = "./testmodule"
  commontags = var.roottags
}

module "eksaws" {
  source      = "./eksaws"
  commontags  = var.roottags
  eksdeployer = var.eksdeployer
}

module "registries" {
  source     = "./registries"
  regnames   = var.ecr_names
  commontags = var.roottags
}

output "main_secret" {
  value       = module.wasserraptor # aws_iam_access_key.iam_ackey_wrp.encrypted_secret
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
