provider "aws" {
  profile = "${var.profile}"
  region  = "${var.default_region}"
}
