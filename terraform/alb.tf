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
