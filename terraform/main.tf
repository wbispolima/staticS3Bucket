terraform {
  required_version = ">=1.8.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.45.00"
    }
  }
  backend "s3" {
    bucket = "ifmt-devops-tfstate"
    key    = "staticS3Bucket/terraform.tfstate"
    region = "sa-east-1"
    encrypt = true
    dynamodb_table = "nome-da-tabela-dynamodb-para-locking"  # Se estiver usando bloqueio de estado
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

