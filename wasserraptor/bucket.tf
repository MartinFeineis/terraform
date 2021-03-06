resource "aws_s3_bucket" "wasserraptor_bucket" {
  bucket = "wasserraptorde"
  acl    = "public-read"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "PublicReadGetObject",
          "Effect": "Allow",
          "Principal": "*",
          "Action": [
              "s3:GetObject"
          ],
          "Resource": [
              "arn:aws:s3:::wasserraptorde/*"
          ]
      }
  ]
}
EOF
  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Name        = "Wasserraptor"
    terraformed = "true"
  }
}

resource "aws_s3_bucket" "wasserraptor_logs" {
  bucket = "wasserraptorlogs"
  acl    = "private"
}
