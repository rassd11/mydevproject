
module "ec2" {
  source = "../../modules/ec2"

  instance_type = var.instance_type
  environment   = var.environment
}


module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr    = var.vpc_cidr
  environment = var.environment
}

module "s3" {
  source = "../../modules/s3"

}

module "cloudfront" {
  source = "../../modules/cloudfront"

}