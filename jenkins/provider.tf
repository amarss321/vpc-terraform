terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.region
  access_key = "AKIAYDN35DRB6GANMOOA"
  secret_key = "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"
}