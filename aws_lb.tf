resource "aws_lb" "main" {
  name                       = "${var.app_name}-lb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = ["${aws_security_group.lb_sg.id}"]
  subnets                    = ["${aws_subnet.public1.id}", "${aws_subnet.public2.id}"]
  enable_deletion_protection = false

  # access_logs {
  #   bucket  = "${aws_s3_bucket.lb_accesslog.bucket}"
  #   prefix  = "lb"
  #   enabled = true
  # }

  tags = {
    Environment = "${var.environment}"
  }
}

resource "aws_lb_target_group" "main" {
  name        = "${var.app_name}-lb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "${aws_vpc.main.id}"
  target_type = "ip"
}

resource "aws_alb_listener" "main" {
  load_balancer_arn = "${aws_lb.main.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.main.id}"
    type             = "forward"
  }
}
