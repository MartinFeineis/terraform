locals {
  module = basename(abspath("."))
}

variable "commontags" {}

resource "aws_ssm_parameter" "dev_param" {
  name        = "/Development/Parameter"
  description = "The parameter description"
  value       = "TestThis"
  type        = "String"
  tags = merge({
    environment = "production",
    Module      = local.module

  }, var.commontags)
}

output "paramoutput" {
  value = aws_ssm_parameter.dev_param.arn
}

output "paramModule" {
  value = locals.module
}
