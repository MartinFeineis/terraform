variable "commontags" {}

resource "aws_ssm_parameter" "dev_param" {
  name        = "Development Parameter"
  description = "The parameter description"
  value       = "TestThis"
type = "String"
  tags = merge ({
    environment = "production"
  }, var.commontags)
}

output "paramoutput" {
 value = aws_ssm_parameter.dev_param.arn
}
