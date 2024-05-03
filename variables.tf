variable "cidr_block" {
  description = "VPC cidr block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_cidr_block" {
  description = "Cidr block for public subnet"
  type        = string
  default     = "10.0.10.0/24"
}

variable "private_cidr_block" {
  description = "Cidr block for public subnet"
  type        = string
  default     = "10.0.20.0/24"
}
