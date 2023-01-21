terraform {
  cloud {
    organization = "raja-aws-test-dev"

    workspaces {
      name = "practice-aws"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

