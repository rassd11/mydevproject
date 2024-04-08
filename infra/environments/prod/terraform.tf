terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.6.0"
    }
  }

  required_version = ">= 1.4"

  backend "s3" {
    bucket = "tfvars-envs"
    region = "eu-central-1"
    key    = "${environment}/terraform.tfstate"
  }
}