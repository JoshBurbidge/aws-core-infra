resource "aws_lb" "main_lb" {
  name               = "main-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = data.aws_security_groups.default_vpc_sgs.ids
  subnets            = data.aws_subnets.subnets.ids

  tags = {
    app = "forum-server"
  }
}

import {
  to = aws_lb.main_lb
  id = "arn:aws:elasticloadbalancing:us-east-1:575737149124:loadbalancer/app/main-lb/d72b31cf256392a1"
}

resource "aws_lb_listener" "main_lb_https_listener" {
  load_balancer_arn = aws_lb.main_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = data.aws_acm_certificate.cert.arn

  default_action {
    type = "fixed-response"
    fixed_response {
      status_code  = 200
      content_type = "text/plain"
      message_body = "HTTPS listener default action"
    }
  }

  tags = {
    app = "forum-client"
  }
}

import {
  to = aws_lb_listener.main_lb_https_listener
  id = "arn:aws:elasticloadbalancing:us-east-1:575737149124:listener/app/main-lb/d72b31cf256392a1/ac0d192325e4ad92"
}
