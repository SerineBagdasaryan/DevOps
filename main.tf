provider "aws" {
  access_key = "secret"
  secret_key = "secret"
  region     = "eu-central-1"
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_instance_profile" "iam_profile" {
  name = "iam_profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_role_policy" "ec2_policy" {
  name = "ec2_policy"
  role = aws_iam_role.ec2_role.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "s3:*"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_instance" "homework_1" {
  count                = 3
  ami                  = "secret"
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.iam_profile.name
}