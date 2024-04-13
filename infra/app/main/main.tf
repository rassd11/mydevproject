


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
  cookies_forward = var.cookies_forward
  geo_restriction = var.geo_restriction
  
}




resource "null_resource" "write_to_env" {
  depends_on = [module.cf]
  provisioner "local-exec" {
    command = <<-EOT
      terraform output >> asd.txt
      cat asd.txt
    EOT
  }
}


