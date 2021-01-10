resource "aws_s3_bucket" "wasserraptor_bucket" {
  bucket = "wasserraptorde"
  acl    = "private"

  tags = {
    Name        = "Wasserraptor"
    terraformed = "true"
  }
}
