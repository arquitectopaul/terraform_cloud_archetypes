resource "aws_acm_certificate" "cert" {
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = var.acm_validation_method

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation_record" {
  for_each = {
    for d in aws_acm_certificate.cert.domain_validation_options : d.domain_name => {
      name   = d.resource_record_name
      record = d.resource_record_value
      type   = d.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = var.acm_ttl
  type            = each.value.type
  zone_id         = data.aws_route53_zone.this.zone_id
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for r in aws_route53_record.cert_validation_record : r.fqdn]
  timeouts {
    create = var.create_timeout
  }
}
