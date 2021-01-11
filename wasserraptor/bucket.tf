resource "aws_s3_bucket" "wasserraptor_bucket" {
  bucket = "wasserraptorde"
  acl    = "public-read"

  tags = {
    Name        = "Wasserraptor"
    terraformed = "true"
  }
}
