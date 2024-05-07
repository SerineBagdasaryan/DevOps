variable "strNumber" {
  default = "100"
}

output "number" {
  value = parseint(var.strNumber, 10)
}

variable "first_name" {
  default = "John"
}

variable "last_name" {
  default = "Doe"
}

output "full_name" {
  value = concat([var.first_name, " ", var.last_name])
}

variable "colors" {
  default = ["red", "green", "blue"]
}

output "selected_color" {
  value = element(var.colors, 1)  # 1 is index
}
variable "name" {
  default = "John"
}

output "greeting" {
  value = format("Hello, %s!", var.name)
}
variable "tags" {
  default = ["web", "app", "database"]
}

output "tag_string" {
  value = join(", ", var.tags)
}
variable "email" {
  default = "john.doe@example.com"
}

output "username" {
  value = replace(element(split("@", var.email), 0), ".", "_")
}
variable "numbers" {
  default = [10, 20, 30, 40, 50]
}

output "doubled_numbers" {
  value = distinct(flatten([for num in var.numbers: [num, num * 2]]))
}
variable "teams" {
  default = ["TeamA", "TeamB", "TeamC"]
}

variable "members" {
  default = [["Alice", "Bob"], ["Charlie", "David"], ["Eve", "Frank"]]
}

output "team_members" {
  value = zipmap(var.teams, var.members)
}

output "current_timestamp" {
  value = timestamp()
}
variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

output "subnet_cidrs" {
  value = [for az in var.availability_zones : cidrsubnet(var.vpc_cidr_block, 8, index(var.availability_zones, az))]
}
