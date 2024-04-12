


module "s3" {
  source = "../modules//s3"
  s3_name = var.s3_name
  region = var.region
  tag_Name = var.tag_Name
  tag_Owner = var.tag_Owner
  tag_Terraform = var.tag_Terraform
  policy_type = var.policy_type
}

module "cf" {
  source = "../modules//cf"
  s3_name = var.s3_name
  region = var.region
  cf_origin_access_identity_path = module.s3.cf_origin_access_identity_path
  cf_default_certificate = var.cf_default_certificate
  tag_Name = var.tag_Name
  tag_Owner = var.tag_Owner
  tag_Terraform = var.tag_Terraform
  cookies_forward = var.cookies_forwarding
  geo_restriction = var.geo_restrictions
  
}

resource "null_resource" "write_to_env" {
  provisioner "local-exec" {
    command = <<-EOT
      export CLOUDFRONT_DOMAIN="${module.cf.cloudfront_domain_name}"
    EOT
  }
}