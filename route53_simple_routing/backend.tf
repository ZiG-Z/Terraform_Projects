terraform {
  backend "s3" {
    bucket = "terraform.bkt"
    key    = "terraform/demo-05"
    region = "ap-southeast-1"
  }
}