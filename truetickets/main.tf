resource "aws_s3_bucket_object" "tt_userdata" {
  bucket = "aws-codestar-us-east-1-703292127192"
  key    = "tt_userdata"
  source = "truetickets/bootstrapper.sh"
}


resource "aws_iam_role" "s3_bootstrapper" {
  name = "test_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      Project = "TrueTicket"
  }
}

resource "aws_iam_instance_profile" "tt_profile" {
  name = "trueticket_profile"
  role = "${aws_iam_role.s3_bootstrapper.name}"
}

resource "aws_iam_role_policy" "test_policy" {
  name = "test_policy"
  role = "${aws_iam_role.s3_bootstrapper.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

#resource "aws_default_vpc" "default" {
#  tags = {
#    Name = "Default VPC"
#  }
#}

resource "aws_security_group" "sshhttphttps" {
  name        = "allow_ssh_sg"
  description = "Allow SSH inbound connections"
  vpc_id = aws_default_vpc

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.gs-vpc.cidr_block]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.gs-vpc.cidr_block]
  }

# ingress {
#   from_port   = 22
#   to_port     = 22
#   protocol    = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
# }
}

resource "aws_key_pair" "truetickets-key" {
  key_name   = "truetickets-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCwrtmmgOnbb5J4qJIXUdwIwZyPlfvUXDChDQAySwLSxsvprTMLeZdK10YH4NWFlNPyh4kvmkysiwsagLeJ2lrIo6KMReH2qcGNNveFDMENCZ+x/O/LKshXjw2wtY69az51a7oQMppeYNw0w707lA5FLOP2ixeu7DjDzyYA9aDKzGf9PdBf9Gt5NEAfW7L27blcFir99hgW9kjpJfGZXakpPTN+rTmn6WG8JRf771Q2SrGjP37ORgNIRJhk7JokyMm0VkFv6Ti65Szv/7GedtqaNlQsQ2gdrXiPg4T8tmGmEtnPPiNI1naKkuZWFxJd/6gwgob5Mc/pPT+utETwnJ7n truetickets"
}


resource "aws_instance" "web" {
  ami           = "ami-03d315ad33b9d49c4"
  instance_type = "t3.micro"
  user_data     = "aws s3 cp s3://aws-codestar-us-east-1-703292127192/tt_userdata bootstrapper.sh && chmod +x bootstrapper.sh && ./bootstrapper.sh -w 0"
  iam_instance_profile = "${aws_iam_instance_profile.tt_profile.name}"
  vpc_security_group_ids = [ aws_security_group.sshhttphttps.id ]
  key_name      = "truetickets-key" 
  tags = {
    Project        = "TrueTicket"
    terraformed    = true
    Name           = "TrueTicketEC2"
  }
}

