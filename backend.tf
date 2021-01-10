resource "aws_s3_bucket" "remote_state_bucket" {
  bucket = "villapenguinremotestatebucket"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    terraformed = true
  }
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = "terraform-state-lock-dynamo"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "TerraformRemoteState"
    terraformed = true
  }
}

#terraform {
#  backend "s3" {
#    bucket         = "villapenguinremotestatebucket"
#    key            = "circleci/remotestate"
#    region         = "us-east-1"
#    dynamodb_table = "dynamodb-terraform-state-lock"
#    encrypt        = true
#  }
#}
