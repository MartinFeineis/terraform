provider "aws" {
  assume_role {
    role_arn = join("", ["arn:aws:iam::", var.devaccountId, ":role/OrganizationAccountAccessRole"])
  }

  alias  = "develop"
  region = "us-east-1"
}

resource "aws_codecommit_repository" "nuxt_amplify" {
  provider        = aws.develop
  repository_name = "nuxt_amp"
  description     = "Running Nuxt on amplif"
}

output "repository" {
  value     = aws_codecommit_repository.nuxt_amplify.clone_url_ssh
}
