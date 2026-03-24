terraform {
  required_version = ">= 1.5.0"
  
  backend "s3" {
    bucket         = "saul-cloud-resume-tf"
    key            = "cloud-resume/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.28.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}