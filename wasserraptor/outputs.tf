#output "aws_iam_access_key" {
#  value = aws_iam_access_key.iam_ackey_wrp.name
#}

output "iam_key" {
  value       = aws_iam_access_key.iam_ackey_wrp.encrypted_secret
  description = "Secret Key for IAM User"
  sensitive   = true
}
