resource "aws_s3_bucket" "lb_accesslog" {
  bucket = "${var.app_name}-${var.environment}-lb-accesslog"
  acl    = "private"

  tags = {
    Name        = "${var.app_name}"
    Environment = "${var.environment}"
  }
}
