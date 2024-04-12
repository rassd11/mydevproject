variable "s3_name" {
    description = "aws s3 bucket name"
}
variable "region" {
    description = "region for resources and bucket - DIFFRENT FROM TFSTATE"
}
variable "cf_default_certificate" {
    description = "certificate used for cloudfront distribution"
}
variable "tag_Name" {
    description = "resource name"
}
variable "tag_Owner" {
    description = "owner's name"
}
variable "tag_Terraform" {
    description = "is terraform used?"
    
}
variable "cookies_forward" {
    description = "choose how the cookies forwarding being used , mostly for cache"
}
variable "geo_restriction" {
    description = "block or allow access from specific geo location"
}
variable "policy_type" {
    description = "type of the policy"
}
