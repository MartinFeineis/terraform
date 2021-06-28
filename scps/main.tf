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

data "aws_iam_policy_document" "mailbox" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = ["ses.amazonaws.com"]
    }
    actions = [
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::nxtgenenginemails", 
      "arn:aws:s3:::nxtgenenginemails/*", 
    ]
  }
}

resource "aws_s3_bucket_policy" "mailbox" {
  bucket = aws_s3_bucket.nxtgenbucket.id
  policy = data.aws_iam_policy_document.mailbox.json
}

resource "aws_route53_record" "nxtgenmxrec" {
  zone_id = "Z2LBEWPVZUG9W2"
  name    = "nxtgenengines.com"
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
    bucket_name = aws_s3_bucket.nxtgenbucket.id
    object_key_prefix = "incomingMails"
    position    = 1
  }
   depends_on = [ aws_s3_bucket.nxtgenbucket ]
}
