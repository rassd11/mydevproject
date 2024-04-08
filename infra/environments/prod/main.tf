# resource "aws_vpc" "env_vpc" {
#   cidr_block      = var.vpc_cidr
#   tags = {
#     environment = var.environment
#   }
# }



module "s3" {
  source = "../../modules/s3"

  instance_type = var.instance_type
  environment   = var.environment
  
  tags = {
  Name = var.name
  Owner = var.owner
  Terraform = var.tf
}
}


module "cloudfront" {
  source = "../../modules/cloudfront"


  # depends_on = [ ec2
  # ]
  tags = {
  Name = var.name
  Owner = var.owner
  Terraform = var.tf
  
}
}
