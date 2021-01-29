
resource "aws_acm_certificate" "gs_acm_cert" {
  domain_name       = join(".",[var.gs_url, var.gs_domain])
  validation_method = "DNS"

  tags = {
    Name = "GetSquire-Domain"
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "gs_route" {
  name         = var.gs_domain
  private_zone = false
}

resource "aws_route53_record" "gs_r53_records" {
  for_each = {
    for dvo in aws_acm_certificate.gs_acm_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.gs_route.zone_id
}

resource "aws_acm_certificate_validation" "gs_validate_cert" {
  certificate_arn         = aws_acm_certificate.gs_acm_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.gs_r53_records : record.fqdn]
}
