resource "cloudflare_record" "application" {
  count = var.infrastructure_config.cloudflare.enabled ? 1 : 0

  zone_id = var.infrastructure_config.cloudflare.zone_id
  name    = var.infrastructure_config.cloudflare.record_name
  value   = aws_lb.app.dns_name
  type    = "CNAME"
  proxied = var.infrastructure_config.cloudflare.proxied
  ttl     = var.infrastructure_config.cloudflare.ttl
}
