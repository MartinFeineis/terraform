provider "aws" {
  region     = "us-east-1"
  access_key = var.accesskey
  secret_key = var.secretkey
}

resource "aws_instance" "web" {
  ami           = "ami-0be2609ba883822ec"
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
    terraformed = true
  }
}
