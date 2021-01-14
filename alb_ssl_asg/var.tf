variable "public_key" {
  type    = string
  default = "mykey.pub"
}

variable "amis" {
  type = map(string)
  default = {
    ap-southeast-1 = "ami-00b8d9cb8a7161e41"
    ap-southeast-2 = "ami-06ce513624b435a22"
    ap-northeast-1 = "ami-01748a72bed07727c"
    ap-norhteast-2 = "ami-0094965d55b3bb1ff"
  }
}

variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "zone_id" {
  type = string
}

variable "certificate_arn" {
  type = string
}