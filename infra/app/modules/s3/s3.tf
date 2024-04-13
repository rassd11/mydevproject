

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "Allows CloudFront to access the S3 bucket"
}

data "aws_iam_policy_document" "this" {
  statement {
    actions   = ["s3:PutObject", "s3:GetObject", "s3:DeleteObject"]
    resources = ["${aws_s3_bucket.this.arn}/*"]

    principals {
      type        = var.policy_type
      identifiers = [aws_cloudfront_origin_access_identity.this.iam_arn]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.this.arn]

    principals {
      type        = var.policy_type
      identifiers = [aws_cloudfront_origin_access_identity.this.iam_arn]
    }
  }
}

resource "aws_s3_bucket" "this" {
  bucket = var.s3_name

  website {
    index_document = "index.html"
  }

  force_destroy = true

  tags = {
    Name = var.tag_Name
    Owner = var.tag_Owner
    Terraform = var.tag_Terraform
  }
}


resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this.json
}
