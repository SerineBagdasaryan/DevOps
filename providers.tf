terraform {
  required_providers {
    aws = {
      version = "~5"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {}
