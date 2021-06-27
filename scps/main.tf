#resource "aws_organizations_policy" "example" {
#  name = "example"
#
#  content = <<CONTENT
#{
#  "Version": "2012-10-17",
#  "Statement": {
#    "Effect": "Allow",
#    "Action": "*",
#    "Resource": "*"
#  }
#}
#CONTENT
#  tags    = merge(var.roottags, var.moduletags)
#}

resource "aws_route53_record" "nxtgenmxrec" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "mail.nxtgenengines.com"
  type    = "MX"
  ttl     = "300"
  records = ["10 inbound-smtp.us-east-1.amazonaws.com"]
}
