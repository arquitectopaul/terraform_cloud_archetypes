output "route53_zone_com_id" {
  description = "The Route53 Zone ID."
  value       = data.aws_route53_zone.this.zone_id
}

output "route53_acm_cert" {
  sensitive = true
  value     = aws_acm_certificate.cert
}
