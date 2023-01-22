/*terraform {
  cloud {
    organization = "raja-aws-test-dev"

    workspaces {
      name = "practice-aws"
    }
  }
}*/

provider "aws" {
  region = "us-west-2"
}

provider "aws" {
  region = "eu-west-1"
  alias  = "eu"
}

