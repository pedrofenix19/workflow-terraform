resource "aws_s3_bucket" "bucket" {
  bucket = "pedro-test-bucket-curso-terraform2-${var.environment}"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.environment == "prod" ? "aws:kms" : "AES256"
        kms_master_key_id = var.environment == "prod" ? module.pedro_key[0].key_id : null
      }
    }
  }
}

module "pedro_key" {
  count = var.environment == "prod"? 1: 0
  source = "terraform-aws-modules/kms/aws"

  description = "Pedro KMS key"
  key_usage   = "ENCRYPT_DECRYPT"

  # Policy
  key_administrators                 = ["arn:aws:iam::412381773585:root"]
  key_service_roles_for_autoscaling  = ["arn:aws:iam::412381773585:root"]

  # Aliases
  aliases = ["pedro-key"]
}

resource "aws_s3_object" "archivos" {
  for_each = var.archivos

  bucket = aws_s3_bucket.bucket.id
  key    = each.key
  content = each.value
}