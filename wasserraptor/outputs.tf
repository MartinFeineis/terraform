#output "aws_iam_access_key" {
#  value = aws_iam_access_key.iam_ackey_wrp.name 
#}

output "secret" {
  value = aws_iam_access_key.iam_ackey_wrp.encrypted_secret
}