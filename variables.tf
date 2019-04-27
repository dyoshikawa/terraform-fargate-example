variable "profile" {
  default = "default"
}

variable "default_region" {
  default = "ap-northeast-1"
}

variable "environment" {
  default = "development"
}

variable "app_name" {
  default = "fargateappname"
}

variable "root_segment" {
  default = "10.10.0.0/16"
}

variable "public_segment1" {
  default = "10.10.10.0/24"
}

variable "public_segment2" {
  default = "10.10.11.0/24"
}

variable "public_segment1_az" {
  default = "ap-northeast-1a"
}

variable "public_segment2_az" {
  default = "ap-northeast-1c"
}
