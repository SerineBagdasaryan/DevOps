resource "aws_vpc" "my-vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.public_cidr_block
  map_public_ip_on_launch = true
  tags = {
    Type = "public"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.private_cidr_block
  tags = {
    Type = "private"
  }
}

resource "aws_internet_gateway" "my-gw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-gw"
  }
}

resource "aws_nat_gateway" "my-nat-gw" {
  depends_on    = [aws_internet_gateway.my-gw]
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id
  tags = {
    Name = "gw NAT"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-tf-lessons-test-bucket"
  tags = {
    Name        = "My bucket"
  }
}

resource "aws_iam_role" "s3_access_role" {
  name               = "s3_access_role"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "s3_access_attachment" {
  role       = aws_iam_role.s3_access_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_instance" "my_instance" {
  ami           = "ami"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id

  iam_instance_profile = aws_iam_instance_profile.my_profile.name

  tags = {
    Name = "MyEC2Instance"
  }
}

resource "aws_iam_instance_profile" "my_profile" {
  name = "my_profile"
  role = aws_iam_role.s3_access_role.name
}
