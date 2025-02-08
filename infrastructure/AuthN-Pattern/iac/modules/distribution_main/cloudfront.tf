resource "aws_cloudfront_distribution" "website" {
  default_root_object = var.default_root_file
  # comment             = var.comment
  comment             = local.app_distribution_name
  enabled             = true
  is_ipv6_enabled     = true
  http_version        = var.cdn_http_version
  aliases             = tolist([var.website_root_domain])
  retain_on_delete    = false
  wait_for_deployment = false

  origin {
    domain_name = aws_s3_bucket.content.bucket_domain_name
    origin_id   = aws_s3_bucket.content.id
    s3_origin_config {
      origin_access_identity = var.cdn_origin_access
    }
  }

  default_cache_behavior {
    target_origin_id           = aws_s3_bucket.content.id
    viewer_protocol_policy     = "redirect-to-https"
    allowed_methods            = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods             = ["GET", "HEAD", "OPTIONS"]
    response_headers_policy_id = var.data_cdn_headers_policy

    compress = true

    # default_ttl = var.cache_ttl
    default_ttl = var.distribution_default_cache_ttl
    # min_ttl     = (var.cache_ttl / 4) < 60 ? 0 : floor(var.cache_ttl / 4)
    min_ttl = floor(var.distribution_default_cache_ttl * 0.2)
    # max_ttl     = floor(var.cache_ttl * 24)
    max_ttl = floor(var.distribution_default_cache_ttl * 4)

    forwarded_values {
      query_string = false

      headers = ["Accept", "Origin", "Access-Control-Request-Method", "Access-Control-Request-Headers"]

      cookies {
        forward = "none"
      }
    }
  }

  price_class = var.price_class
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["PE"]
    }
  }

  custom_error_response {
    error_caching_min_ttl = "0"
    error_code            = "403"
    response_code         = "200"
    response_page_path    = "/index.html"
  }

  custom_error_response {
    error_caching_min_ttl = "0"
    error_code            = "404"
    response_code         = "200"
    response_page_path    = "/index.html"
  }

  viewer_certificate {
    acm_certificate_arn      = var.data_acm_cert_global
    ssl_support_method       = var.cdn_ssl_support_method
    minimum_protocol_version = var.cdn_minimum_protocol_version
  }

  depends_on = [
    var.acm_certificate_cert
  ]

  web_acl_id = var.web_app_firewall
}
