provider "aws" {
  region     = "us-east-1"
  access_key = var.accesskey
  secret_key = var.secretkey
}

resource "aws_s3_bucket_object" "tt_userdata" {
  bucket = "aws-codestar-us-east-1-703292127192"
  key    = "tt_userdata"
  source = "bootstrapper.sh"

  etag = filemd5("bootstrapper.sh")
}

resource "aws_instance" "web" {
  ami           = "ami-0a1e476a62823e750"
  instance_type = "t3.micro"

  tags = {
    Name        = "HelloWorld"
    terraformed = true
  }
}

