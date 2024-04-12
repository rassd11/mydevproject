inputs = {
  aws_access_key = "default_value"
  aws_secret_key = "default_value"
}

locals {
  aws_access_key = terraform.workspace != "production" ? var.aws_access_key : null
  aws_secret_key = terraform.workspace != "production" ? var.aws_secret_key : null
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key 
  secret_key = var.aws_secret_key
}
EOF
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "royi-state-bucket"
    key            = "terragrunt/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "my-lock-table"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
