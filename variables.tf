variable "cidr_block" {
  description = "CIDR block VPC"
  type = string
  default     = "10.0.0.0/16"
}
variable "subnet_cidr_block_1" {
  description = "CIDR block VPC"
  type = string
  default     = "10.0.1.0/24"
}
variable "subnet_cidr_block_2" {
  description = "CIDR block VPC"
  type = string
  default     = "10.0.3.0/24"
}
variable "subnet_cidr_block_3" {
  description = "CIDR block VPC"
  type = string
  default     = "10.0.0.0/24"
}
variable "route_cidr" {
  description = "CIDR block VPC"
  type = string
  default     = "0.0.0.0/0"
}

variable "vpc_name" {
  description = "VPC name"
  type = string
  default     = "custom_vpc"
}
variable "avail_zone" {
  description = "First Availability zone"
  type = string
  default = "eu-central-1a"
}
variable "instance_type" {
  description = "Instance type"
  type = string
  default = "t2.micro"
}