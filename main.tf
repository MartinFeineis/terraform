provider "aws" {
  region     = "us-east-1"
  access_key = var.accesskey
  secret_key = var.secretkey
}

#module "wasserraptor" {
#  source = "./wasserraptor"
#}
#
#module "testy" {
#  source   = "./testmodule"
#  roottags = var.roottags
#}

#module "users" {
#  source   = "./iam"
#}

module "bill" {
  source                    = "./billing"
  monthly_billing_threshold = 13
  currency                  = "USD"
  roottags                  = var.roottags
}

module "scps" {
  source      = "./scps"
  target_id = var.target_id
  region_lockdown = [
  "eu-north-1", "ap-south-1", "eu-west-3", "eu-west-2", "eu-west-1", "ap-northeast-3", "ap-northeast-2", "ap-northeast-1", "sa-east-1", "ca-central-1", "ap-southeast-1", "ap-southeast-2", "eu-central-1", "us-east-2", "us-west-1", "us-west-2" ]
}

#module "messenger" {
#  source      = "./messenger"
#}

#module "eksaws" {
#  source      = "./eksaws"
#  roottags    = var.roottags
#  eksdeployer = var.eksdeployer
#}

#module "registries" {
#  source   = "./registries"
#  regnames = var.ecr_names
#  roottags = var.roottags
#}

#output "main_secret" {
#  value       = module.wasserraptor
#  description = "Secret Key for IAM User in main"
#  sensitive   = true
#}

#output "paramout" {
#  value = module.testy
#}
