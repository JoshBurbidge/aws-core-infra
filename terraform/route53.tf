resource "aws_route53_record" "main_lb_dns" {
  name    = "zzzyx.click"
  zone_id = data.aws_route53_zone.domain_zone.zone_id
  type    = "A"

  alias {
    name                   = aws_lb.main_lb.dns_name
    zone_id                = aws_lb.main_lb.zone_id
    evaluate_target_health = true
  }
}

import {
  to = aws_route53_record.main_lb_dns
  id = "Z0424378XVXHOFVZNJ5G_zzzyx.click_A"
}

data "aws_route53_zone" "domain_zone" {
  name = "zzzyx.click"
}
