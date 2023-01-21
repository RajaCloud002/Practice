provider "aws" {
  region = "us-west-2"
}

provider "aws" {
  region = "eu-west-1"
  alias  = "eu"
}