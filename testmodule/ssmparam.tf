locals {
  module = basename(abspath("."))
}


resource "aws_ssm_parameter" "dev_param" {
  name        = "/Development/Parameter"
  description = "The parameter description"
  value       = "TestThis"
  type        = "String"
  tags = merge(

    var.moduletags
  , var.roottags)
}

output "paramoutput" {
  value = aws_ssm_parameter.dev_param.arn
}

output "paramModule" {
  value = local.module
}
