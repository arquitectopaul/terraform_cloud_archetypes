data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = local.terraform_remote_state_bucket_name
    key    = "commons/vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "route53" {
  backend = "s3"
  config = {
    bucket = local.terraform_remote_state_bucket_name
    key    = "commons/route53/terraform.tfstate"
  }
}

data "aws_cloudfront_cache_policy" "this" {
  name = "Managed-CachingOptimized"
}

data "aws_cloudfront_origin_request_policy" "this" {
  name = "Managed-CORS-S3Origin"
}

data "aws_cloudfront_response_headers_policy" "this" {
  name = "Managed-SimpleCORS"
}

data "aws_acm_certificate" "cert_global" {
  domain   = coalesce(var.wildcard_ssl, var.website_root_domain)
  statuses = ["ISSUED"]
  provider = aws.virginia_region_provider
}
