resource "aws_route53_zone" "mralien" {
  name = "mralien3399.xyz"
}

resource "aws_route53_record" "record1" {
  zone_id = aws_route53_zone.mralien.id
  name    = "mralien3399.xyz"
  type    = "A"
  ttl     = "30"
  records = [aws_eip.eip-Web01.public_ip]
}