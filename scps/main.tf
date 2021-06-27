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
resource "aws_s3_bucket" "nxtgenbucket" {
  bucket = "nxtgenenginemails"
  acl    = "private"

  tags = {
    Name        = "MailBucket"
    Environment = "Dev"
  }
}


resource "aws_route53_record" "nxtgenmxrec" {
  zone_id = "Z2LBEWPVZUG9W2"
  name    = "mail.nxtgenengines.com"
  type    = "MX"
  ttl     = "300"
  records = ["10 inbound-smtp.us-east-1.amazonaws.com"]
}

resource "aws_ses_receipt_rule" "store" {
  name          = "store"
  rule_set_name = "default-rule-set"
  recipients    = ["*@nxtgenengines.com"]
  enabled       = true
  scan_enabled  = true

  s3_action {
    bucket_name = aws_s3_bucket.nxtgenbucket.name
    object_key_prefix = "incomingMails"
    position    = 2
  }
}
