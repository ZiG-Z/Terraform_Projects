variable "amis" {
  type = map(string)
  default = {
    ap-southeast-1 = "ami-00b8d9cb8a7161e41"
    ap-southeast-2 = "ami-00b8d9cb8a7161e41"
  }
}

variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "public_key" {
  type = string
}

variable "private_key" {
  type = string
}

variable "instance_username" {
  type    = string
  default = "ec2-user"
}