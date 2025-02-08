resource "aws_s3_bucket" "content" {
  # bucket = var.bucket_name
  bucket = local.app_bucket_name
}

resource "aws_s3_bucket_versioning" "disabled" {
  bucket = aws_s3_bucket.content.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.content.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.content.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    sid       = "1"
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.content.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = ["${var.s3_identifiers}"]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.content.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.content.id

  for_each     = fileset("${path.module}/assets/", "*")
  key          = each.value
  source       = "${path.module}/assets/${each.value}"
  etag         = filemd5("${path.module}/assets/${each.value}")
  content_type = "text/html"

  depends_on = [
    aws_s3_bucket.content
  ]

  tags = {
    Name = "${var.resource_name_preffix}s3object${var.resource_name_suffix}"
  }
}
