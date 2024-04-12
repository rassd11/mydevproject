resource "aws_cloudfront_distribution" "this" {
  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = "S3-${var.s3_name}"
    viewer_protocol_policy = "allow-all"
    compress               = true

    min_ttl     = 0
    default_ttl = 5 * 60
    max_ttl     = 60 * 60

    forwarded_values {
      query_string = true

      cookies {
        forward = var.cookies_forwarding
      }
    }
  }

  origin {
    domain_name = "${var.s3_name}.s3.amazonaws.com"
    origin_id   = "S3-${var.s3_name}"

    s3_origin_config {
      origin_access_identity = var.cf_origin_access_identity_path
    }
  }


  restrictions {
    geo_restriction {
      restriction_type = var.geo_restrictions
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = var.cf_default_certificate
  }

  tags = {
    Name = var.tag_Name
    Owner = var.tag_Owner
    Terraform = var.tag_Terraform
    
  }
}
