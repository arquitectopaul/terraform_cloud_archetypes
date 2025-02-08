# Codigos personalizados de tipos de recursos
variable "custom_bucket_resource_code" {}

variable "custom_distribution_resource_code" {}

# Configuracion de recursos a aprovisionar
variable "resource_name_preffix" {}

variable "resource_name_suffix" {}

variable "frontend_name" {}

# variable "bucket_name" {
#   description = "Name to give this environment."
# }

variable "website_root_domain" {}

variable "main_wildcard_ssl" {}

variable "acm_certificate_cert" {}

variable "acm_zone_id" {}

variable "acm_record_type" {
  default = "A"
}

variable "acm_evaluate_target_health" {
  default = true
}

# variable "comment" {}

# variable "aliases" {
#   description = "Additional aliases to host this website for."
#   default     = []
# }

# variable "cache_ttl" {
#   description = "Default TTL to give objects requested from S3 in CloudFront for caching."
#   default     = 3600
# }

variable "distribution_default_cache_ttl" {}

variable "price_class" {
  description = "Which price_class to enable in CloudFront."
  default     = "PriceClass_All"
}

variable "cdn_http_version" {
  type    = string
  default = "http2"
}

variable "cdn_ssl_support_method" {
  type    = string
  default = "sni-only"
}

variable "cdn_minimum_protocol_version" {
  type    = string
  default = "TLSv1.2_2021"
}

variable "cdn_comment_origin_access_identity" {
  type    = string
  default = "CloudFront OAI"
}

variable "texto_name" {
  type    = string
  default = "CloudFront"
}

variable "default_root_file" {
  type    = string
  default = "index.html"
}

variable "web_app_firewall" {}

variable "web_app_firewall_arn" {}

variable "aws_waf_rule_arn" {}

variable "aws_waf_rule_id" {}

variable "aws_waf_rule_group_arn" {}

variable "aws_waf_rule_group_id" {}

variable "data_cdn_cache_policy" {}

variable "data_cdn_origin_policy" {}

variable "data_cdn_headers_policy" {}

variable "data_acm_cert_global" {}

variable "s3_identifiers" {}

variable "cdn_origin_access" {}
