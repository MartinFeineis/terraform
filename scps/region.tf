#-----security_controls_scp/modules/account/deny_region_usage.tf----#

data "aws_iam_policy_document" "region_restriction" {
  statement {
    sid = "DenyRegionUsage"

    actions = [
      "*",
    ]

    resources = [
      "*",
    ]

    effect = "Deny"

    condition {
      test     = "StringEqualsIgnoreCase"
      variable = "aws:RequestedRegion"
      values   = var.region_lockdown
    }
  }
}

resource "aws_organizations_policy" "region_restriction" {
  name        = "Deny Region Interaction"
  description = "Deny the ability to invoke APIs in regions outside the above"

  content = data.aws_iam_policy_document.region_restriction.json
}

resource "aws_organizations_policy_attachment" "region_restriction_attachment" {
  policy_id = aws_organizations_policy.region_restriction.id
  target_id = var.target_id
}
