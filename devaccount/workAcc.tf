resource "aws_iam_user" "workaccount" {
  name     = "workaccount"
  provider = aws.develop
}

resource "aws_iam_access_key" "workaccount_key" {
  user     = aws_iam_user.workaccount.id
  provider = aws.develop
}

resource "aws_iam_user_ssh_key" "work_key_codecommit" {
  username   = aws_iam_user.workaccount.name
  encoding   = "SSH"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDA1m1ydderfxSrSBZyUMeXTo9n0fDkA9kiYqBUmjjsZs5YZtkXSQkBSREiJTW2qYEBrTSu5pXE5P7y5CB2U1bFtr7sPmUQIhkv1tSUPQusuB1tPat/C/PF3ECJYyebm+UV8pII78M7yB24jqYKCGROkLYhZDnxuTuk27ZG+LveKewmaUR9NJH0abkxVyt0nPCLII8J5Ytshm5HckzZ05pofRrKyhrxXuWh3og/0pHVXPzLpS46/weLJqdb7D2CmOezcoOKWicGLJPiAy4tyhkitxyE9WIlNHjJhoTtRHVXcvVIR5rtSRweIj9OX5mNLu3QhYH4IIJ/8PDRceQafw2N aws develop acc codecommit"
  provider   = aws.develop
}

output "workaccount_id" {
  value = aws_iam_access_key.workaccount_key.id
}

output "work_ssh_key" {
  value = aws_iam_user_ssh_key.ssh_key_codecommit.ssh_public_key_id
}

output "workaccount_secret" {
  value     = aws_iam_access_key.workaccount_key.secret
  sensitive = true
}
