terraform {
  required_version = "1.0.8"

  required_providers {
    aws = {
      version = ">= 3.63.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "sa-east-1"
}

resource "aws_s3_bucket" "private_bucket" {
  bucket = "com.komutilo.tomatinho.terraform-remote-state-dev"
  acl    = "private"

  tags = {
    Name        = "com.komutilo.tomatinho.terraform-remote-state-dev"
    Environment = "Dev"
  }
}

resource "aws_dynamodb_table" "lock_table" {
  name           = "com.komutilo.tomatinho.terraform-lock-dev"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
