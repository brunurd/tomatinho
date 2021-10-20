terraform {
  required_version = "1.0.8"

  required_providers {
    aws = {
      version = ">= 3.63.0"
      source  = "hashicorp/aws"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = var.region
}

module "deployment_bucket" {
  source = "../modules/aws-s3-bucket-private"
  name   = "tomatinho-deployment-bucket-${lower(var.stage)}"
  stage  = var.stage
}
