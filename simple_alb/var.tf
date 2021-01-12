variable "public_key" {
  type    = string
  default = "mykey.pub"
}

variable "amis" {
  type = map(string)
  default = {
    ap-southeast-1 = "ami-00b8d9cb8a7161e41"
  }
}

variable "region" {
  type    = string
  default = "ap-southeast-1"
}