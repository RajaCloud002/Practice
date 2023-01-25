provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket-0213245"
  acl    = "private"

  versioning {
    enabled = true
  }
}