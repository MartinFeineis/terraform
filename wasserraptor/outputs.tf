output "aws_iam_access_key" {
  value = aws_iam_user.iam_wrp.name
}

output "secret" {
  value = aws_iam_user.iam_wr.encrypted_secret
}
