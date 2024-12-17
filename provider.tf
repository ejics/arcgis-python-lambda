provider "aws" {
  region = var.region

  # default_tags {
  #   tags = {
  #     Customer = var.customer
  #   }
  # }
}

terraform {
  required_version = ">= 1.2.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.68.0"
    }
  }
}