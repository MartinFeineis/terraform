


resource "aws_s3_bucket" "remote_state_bucket" {
  bucket = "villapenguinremotestatebucket"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    terraformed = true
  }
}

#terraform {
#  backend "s3" {
#    bucket         = "villapenguinremotestatebucket"
#    key            = "remotestate"
#    region = "us-east-1"
#    dynamodb_table = "villapenguintfrmstate"
#    encrypt        = true
#  }
#}
