provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "my-tf-log-bucket-02132454"
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket-012d2d2a1d"
  acl    = "private"

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }
}