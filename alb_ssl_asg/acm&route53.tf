resource "aws_route53_record" "mralien3399" {
  zone_id = var.zone_id
  name    = "mralien3399.xyz"
  type    = "A"
  alias {
    name                   = aws_lb.myalb.dns_name
    zone_id                = aws_lb.myalb.zone_id
    evaluate_target_health = true
  }
}