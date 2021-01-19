provider "aws" {
  region = "ap-southeast-1"
  alias = "sg"
}

#S3 Replicate to Tokyo Region

provider "aws" {
  region = "ap-northeast-1"
}
