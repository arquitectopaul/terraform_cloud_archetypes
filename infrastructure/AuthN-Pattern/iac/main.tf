module "distribution-main" {
  source = "./modules/distribution_main"

  frontend_name = var.main_frontend_name

  resource_name_preffix = local.resource_name_preffix
  resource_name_suffix  = local.resource_name_suffix

  custom_bucket_resource_code       = var.custom_bucket_resource_code
  custom_distribution_resource_code = var.custom_distribution_resource_code

  distribution_default_cache_ttl = var.distribution_default_cache_ttl


  website_root_domain = var.website_root_domain
  main_wildcard_ssl   = var.wildcard_ssl

  acm_zone_id          = data.terraform_remote_state.route53.outputs.route53_zone_com_id
  acm_certificate_cert = data.terraform_remote_state.route53.outputs.route53_acm_cert

  data_cdn_cache_policy   = data.aws_cloudfront_cache_policy.this
  data_cdn_origin_policy  = data.aws_cloudfront_origin_request_policy.this
  data_cdn_headers_policy = data.aws_cloudfront_response_headers_policy.this.id
  data_acm_cert_global    = data.aws_acm_certificate.cert_global.arn

  web_app_firewall     = aws_waf_web_acl.waf_acl.id
  web_app_firewall_arn = aws_waf_web_acl.waf_acl.arn

  aws_waf_rule_arn       = aws_waf_rule.waf_rule.arn
  aws_waf_rule_id        = aws_waf_rule.waf_rule.id
  aws_waf_rule_group_arn = aws_waf_rule_group.rule_group.arn
  aws_waf_rule_group_id  = aws_waf_rule_group.rule_group.id

  s3_identifiers    = aws_cloudfront_origin_access_identity.website.iam_arn
  cdn_origin_access = aws_cloudfront_origin_access_identity.website.cloudfront_access_identity_path
}

module "distribution-microfront" {
  source = "./modules/distribution_microfront"

  for_each      = { for index, app_name in var.microfrontend_names : app_name => app_name }
  frontend_name = each.value

  app_name_prefix = var.microfrontend_app_name_prefix

  resource_name_preffix = local.resource_name_preffix
  resource_name_suffix  = local.resource_name_suffix

  custom_bucket_resource_code       = var.custom_bucket_resource_code
  custom_distribution_resource_code = var.custom_distribution_resource_code

  distribution_default_cache_ttl = var.distribution_default_cache_ttl


  website_root_domain = var.website_root_domain
  main_wildcard_ssl   = var.wildcard_ssl

  acm_zone_id          = data.terraform_remote_state.route53.outputs.route53_zone_com_id
  acm_certificate_cert = data.terraform_remote_state.route53.outputs.route53_acm_cert

  data_cdn_cache_policy   = data.aws_cloudfront_cache_policy.this
  data_cdn_origin_policy  = data.aws_cloudfront_origin_request_policy.this
  data_cdn_headers_policy = data.aws_cloudfront_response_headers_policy.this.id
  data_acm_cert_global    = data.aws_acm_certificate.cert_global.arn

  web_app_firewall     = aws_waf_web_acl.waf_acl.id
  web_app_firewall_arn = aws_waf_web_acl.waf_acl.arn

  aws_waf_rule_arn       = aws_waf_rule.waf_rule.arn
  aws_waf_rule_id        = aws_waf_rule.waf_rule.id
  aws_waf_rule_group_arn = aws_waf_rule_group.rule_group.arn
  aws_waf_rule_group_id  = aws_waf_rule_group.rule_group.id

  s3_identifiers    = aws_cloudfront_origin_access_identity.website.iam_arn
  cdn_origin_access = aws_cloudfront_origin_access_identity.website.cloudfront_access_identity_path
}
