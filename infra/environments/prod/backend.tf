  terraform{
  backend "s3" {
    bucket = "tfvars-envs"
    region = "eu-central-1"
    key    = "${environment}/terraform.tfstate"
  }
}