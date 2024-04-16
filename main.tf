provider "aws" {}

resource "aws_vpc" "custom_vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name: var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.custom_vpc.id
  cidr_block = var.subnet_cidr_block_1
  availability_zone = var.avail_zone
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.subnet_cidr_block_2
  availability_zone       =  var.avail_zone
}

resource "aws_subnet" "db_subnet" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.subnet_cidr_block_3
  availability_zone       = var.avail_zone
}
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block = var.route_cidr
    gateway_id = aws_internet_gateway.igw.id
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id
}
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_security_group" "my_security_group" {
  name        = "security_group"
  description = "Allow access"

  vpc_id = aws_vpc.custom_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bastion_instance" {
  ami           = ""
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
}

resource "aws_instance" "backend_instance" {
  ami           = ""
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
}

resource "aws_instance" "db_instance" {
  ami           = ""
  instance_type = var.instance_type
  subnet_id     = aws_subnet.db_subnet.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
}