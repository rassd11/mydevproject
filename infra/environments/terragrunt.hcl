include "root" {
  paths = [find_in_parent_folders()]
}


terraform {
  source = "../app//main"
}

dependencies {
  outputs = {
    cloudfront_domain_name = dependency.cf.output["cloudfront_domain_name"]
  }
}

inputs = {
  s3_name = "royis-bucket"
  region = "us-east-1"
  cf_default_certificate = "true"
  cookies_forward = "none"
  geo_restriction = "none"
  policy_type = "AWS"
  tag_Name = "ProductCloudFront"
  tag_Owner = "RoyiS"
  tag_Terraform = "True"
  cloudfront_domain_name = dependency.output.cloudfront_domain_name


}

