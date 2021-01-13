resource "aws_ssm_parameter" "dev_param" {
  name        = "Development Parameter"
  description = "The parameter description"
  value       = "TestThis"

  tags = merge ({
    environment = "production"
  }, var.commontags)
}
