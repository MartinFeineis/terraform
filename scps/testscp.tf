data "aws_iam_policy_document" "deny_all_ec2" {
  statement {
    sid = "denyAllEc2actions"

    actions = [
      "ec2:*",
    ]

    resources = [
      "*",
    ]

    effect = "Deny"
  }
}

resource "aws_organizations_policy" "deny_all_ec2_policy" {
  name        = "Deny All EC2 actions"
  description = "Deny the ability to manipulate CloudTrail"

  content = data.aws_iam_policy_document.deny_all_ec2.json
}

resource "aws_organizations_policy_attachment" "deny_all_ec2_attachment" {
  policy_id = aws_organizations_policy.deny_all_ec2_policy.id
  target_id = var.target_id
}
