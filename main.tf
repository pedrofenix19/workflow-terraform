resource "aws_s3_bucket" "bucket" {
  bucket = "pedro-test-bucket-curso-terraform2-${var.environment}"
}