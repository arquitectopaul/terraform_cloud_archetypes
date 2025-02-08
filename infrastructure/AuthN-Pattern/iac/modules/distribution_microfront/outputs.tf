output "domain_name" {
  description = "The URL for the Website."
  value       = "https://${var.website_root_domain}/"
}

output "aliases" {
  # value = aws_cloudfront_distribution.website.aliases
  value = [for index, aliase in aws_cloudfront_distribution.website.aliases : "https://${aliase}"]
}

output "s3_bucket_name" {
  description = "The name of the S3 content bucket to upload the website content to."
  value       = aws_s3_bucket.content.id
}

output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront Distribution."
  value       = aws_cloudfront_distribution.website.id
}

output "cloudfront_distribution_hostname" {
  description = "The hostname of the CloudFront Distribution (use for DNS CNAME)."
  value       = aws_cloudfront_distribution.website.domain_name
}

output "cloudfront_zone_id" {
  description = "The Zone ID of the CloudFront Distribution (use for DNS Alias)."
  value       = aws_cloudfront_distribution.website.hosted_zone_id
}

# output "tolist" {
#   value = tolist([var.website_root_domain])
# }

# output "alias_name" {
#   value = concat(tolist([var.website_root_domain]), var.aliases)
# }

# output "aliases" {
#   value = var.aliases
# }

# output "alias_name2" {
#   value = compact(concat(tolist([var.website_root_domain]), var.aliases))
# }

output "aws_waf_rule_arn" {
  value = var.aws_waf_rule_arn
}

output "aws_waf_rule_id" {
  value = var.aws_waf_rule_id
}

output "aws_waf_web_acl_arn" {
  value = var.web_app_firewall_arn
}

output "aws_waf_web_acl_id" {
  value = var.web_app_firewall
}

output "aws_waf_rule_group_arn" {
  value = var.aws_waf_rule_group_arn
}

output "aws_waf_rule_group_id" {
  value = var.aws_waf_rule_group_id
}
