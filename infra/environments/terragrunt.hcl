include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../app//main"
}


inputs = {
  s3_name = "me-bucket"
  region = "us-east-1"
  cf_default_certificate = "true"
  cookies_forward = "none"
  geo_restriction = "none"
  policy_type = "AWS"
  tag_Name = "ProductCloudFront"
  tag_Owner = "MeS"
  tag_Terraform = "True"
  
}


