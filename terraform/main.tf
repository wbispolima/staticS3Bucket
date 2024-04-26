terraform {
  required_version = ">=1.8.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.45.00"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "sa-east-1"

  default_tags {
    tags = {
      owner      = "profbispo"
      managed-by = "terraform"
    }
  }
}

