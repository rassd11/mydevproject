remote_state {
  backend = "s3"
  config = {
    bucket         = "me-state-bucket"
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
