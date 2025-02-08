resource "aws_route53_record" "websiteurl" {
  name    = var.website_root_domain
  zone_id = var.acm_zone_id
  type    = var.acm_record_type

  alias {
    name                   = aws_cloudfront_distribution.website.domain_name
    zone_id                = aws_cloudfront_distribution.website.hosted_zone_id
    evaluate_target_health = true
  }
}
